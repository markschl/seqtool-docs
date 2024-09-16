
## Expressions

*Seqtool* can evaluate mathematical expressions, but also supports
more complex programming code; thanks to the tiny integrated
[JavaScript](https://en.wikipedia.org/wiki/JavaScript) engine ([QuickJS](https://bellard.org/quickjs)).
This allows for solving problems that would normally require writing a custom script
(which would often run slower).

Another important use case for expressions is the powerful [filter](filter.md) command.

A comprehensive **JavaScript language overview** can be found on
[this Mozilla site](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Language_overview).

### Usage

Expressions are always written in curly brackets: `{ expression }`.
They can be used at any place where [variables/functions](variables.md) are allowed.

> **Exception:** [filtering expressions](filter.md) don't need braces

### Strings + numbers

JavaScript has a special behavior when it comes to adding strings + numbers:

`"a" + 1` just concatenates the two, producing the string `"a1"`.
Things become confusing if numbers are stored as strings: `"1" + 2` gives `"12"`
instead of just `3`.

In seqtool, many [variables/functions](variables.md) are (respectively return)
text/strings.
Examples for numeric variables are [`seqhash`](var_reference.md#seqhash),
[`seq_num`](var_reference.md#seq_num)
as well as all [sequence statistics](var_reference.md#sequence-statistics) variables.
The exact type can be found by typing `st <command> --help-vars`:

![Variable help example](img/varhelp.png)

*TODO: add type to [var reference](var_reference.md)*

Functions for **[header attribute](attributes.md)** and **[metadata](meta.md)**
access are the most prone to this issue. The functions `attr(name)` and `meta(column)`
always return text, since *seqtool* doesn't know or check whether the given text
is a number or not. 
Consequently, `attr("name") + 1` will just **concatenate** `1` to the attribute
value instead of adding the numbers.

**Solution**: Convert to numeric with the
[`num`](var_reference.md#data-conversion-and-transformation)
function: `num(attr("name")) + 1`.
*Num* works like `parseFloat()`, but stops with an error if the given string is
not a number.

### String function arguments

A peculiarity of seqtool functions are *unquoted string arguments*.
These are allowed in a non-expression context in order to prevent users from
having to use *both* single and double quotes. Example:

```bash
st sort 'attr(a)' input.fasta
```

As soon as an expression is used, arguments need to be quoted, otherwise the `a`
is interpreted as a variable:

```bash
st sort 'num(attr("a")) + num(attr("b"))' input.fasta
```

### Initialization

(TODO: explain `--js-init`...)

### Regular expressions

Using the [regular expression](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions)
*/literal/* syntax is not possible, since seqtool has its own script parsing routine,
which cannot handle such complex cases. 
Use the `RegExp` class instead, e.g.: `desc.match(new RegExp("xy\d+"))`.