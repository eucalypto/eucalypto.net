---
date: "2016-03-11T18:44:10Z"
type: "post"
image: "/posts/2013-04-14-pdf-tools/pdf-tools-for-printing.webp"
tags:
- linux
- bash
title: Bash Aliases
---


## Aliases for command line in .bashrc

In ubuntu the `.bashrc` file has a command that looks for
`~/.bash_aliases` and includes it. Here you find my [.bash_aliases] file with useful aliases.

This is the code in the .bashrc file:

{{< highlight bash >}}
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
{{< / highlight >}}

[.bash_aliases]: https://raw.githubusercontent.com/eucalypto/potato/master/helpful_potato/linux/bash/dot.bash_aliases
