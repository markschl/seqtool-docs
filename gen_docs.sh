#!/bin/bash

set -euo pipefail

# cargo build

st_dir=../seqtool
seqtool=$st_dir/target/debug/st
st_readme=$st_dir/README.md
templates=_template
outdir=docs
main=docs/index.md
config=mkdocs.yml

(cd $st_dir && cargo build)

# copy mkdocs.yml without the nav
cp $templates/mkdocs.yml $config
echo >> $config

# upper part of the landing page
cp $templates/_home_head.md $main

# Initialize navigation

echo "nav:" >> $config
echo "  - Home: index.md" >> $config
echo "  - Download: https://github.com/markschl/seqtool/releases/latest" >> $config

# generate command files

printf "\n## Commands" >> $main
echo "  - Commands:" >> $config

cmd=(
  ">cmds_basic=Basic conversion/editing" pass
  ">cmds_info=Information about sequences" view count stat
  ">cmds_sub_shuffle=Subset/shuffle" sort unique filter split sample slice head tail interleave
  ">cmds_search_rep=Search and replace" find replace
  ">cmds_mod=Modifying commands" del set trim mask upper lower revcomp concat
)

# create one MD file per command

sub_list=

for cmd in "${cmd[@]}"; do
  echo "$cmd"

  if [[ "$cmd" = ">"* ]]; then
    # category name: write to list on landing page and to nav
    cmd="${cmd:1}"
    sub_list_name=${cmd%%=*}.md
    sub_list=$outdir/$sub_list_name
    desc=${cmd#*=}
    echo -e "\n### $desc" >> $main
    echo -e "\n### $desc" > $sub_list
    echo -e "    - '$desc': $sub_list_name" >> $config
    continue
  fi

  # initialize <command>.md
  out=$outdir/$cmd.md
  echo "# $cmd" > $out

  # commandline usage
  opts=$(stty cols 80 && $seqtool "$cmd" -h 2>&1 | sed -n '/General options/q;p')

  # short description for landing 
  desc=$(echo "$opts" | sed -n '/^ *$/q;p')
  echo "* **[$cmd]($cmd.md)**: $desc" >> $main
  echo "* **[$cmd]($cmd.md)**: $desc" >> $sub_list

  # description before usage
  echo -e "$opts" | sed -n '/Usage:/q;p' >> $out
  echo '```' >> $out
  echo -e "$opts" | sed '/Usage:/,$!d' >> $out
  echo '```' >> $out
  echo '[See this page](opts.md) for the options common to all commands.' >> $out
  echo '' >> $out

  # add custom help content if file exists in doc dir
  desc_f=$templates/$cmd.md
  if [ -f $desc_f ]; then
    cat $desc_f >> $out
  fi

  # add variable help if present
  vars=$($seqtool $cmd  --help-vars-md --help-cmd-vars 2>&1)
  if [ ! -z "$vars" -a "$vars" != " "  ]; then
    msg="see also \`st $cmd --help-vars\`\n"
    echo -e "$vars" | sed -E "s|## Variables/functions provided.+|\n\0\n> $msg|g" >> $out
  fi
done

# lower part of the landing page
echo >> $main
cat _template/_home_foot.md >> $main

# args common to all commands
out=$outdir/opts.md
printf "\n\n### Options recognized by all commands\n\n" > $out
echo "\`\`\`" >> $out
stty cols 80 && $seqtool pass -h 2>&1 | sed '/General options/,$!d' >> $out
echo "\`\`\`" >> $out
echo "  - 'Commandline options': opts.md" >> $config

# variables/functions
out=$outdir/variables.md
cp _template/variables.md $outdir/variables.md
echo "  - 'Variables/functions': variables.md" >> $config
# echo "    - Overview: variables.md" >> $config

# full variables reference
out=$outdir/var_reference.md
echo "# Variables/functions: full reference" > $out
echo "This list can also be viewed in the terminal by running \`st command --help-vars\`" >> $out
echo >> $out
$seqtool . --help-vars-md 2>&1 >> $out
# echo "    - 'Full reference': var_reference.md" >> $config

# other files

cp _template/expressions.md $outdir
echo "  - 'Expressions': expressions.md" >> $config

cp _template/formats.md $outdir
echo "  - 'Formats and compression': formats.md" >> $config

cp _template/attributes.md $outdir
echo "  - 'Header attributes': attributes.md" >> $config

cp _template/meta.md $outdir
echo "  - 'Metadata': meta.md" >> $config

echo "  - 'Other topics':" >> $config

cp _template/ranges.md $outdir
echo "    - 'Ranges': ranges.md" >> $config

cp _template/_comparison_head.md $outdir/comparison.md
cat $st_dir/profile/comparison.md >> $outdir/comparison.md
echo "    - 'Comparison of tools': comparison.md" >> $config

# finally, copy the content of the landing page to seqtool/README.md,
# inserting a link to the gh-page and adjusting the URLs

doc_link="\n## Detailed documentation\n\n**See [this page](https://markschl.github.io/seqtool-docs)**\n\n"
cat $main |
  awk -v doc=$"$doc_link" '/## / && !x {print doc; x=1} 1' |
  sed -E 's|\(([^.)]+)\.md\)|(https://markschl.github.io/seqtool-docs/\1)|g' \
  > $st_readme
