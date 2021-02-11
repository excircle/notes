# How To Get An Alias To AutoComplete In Bash

First you'll need to install the requisite bash program `bash-completion`.

```bash
apt install bash-completion
```

Next, you'll need to grab the bash file `complete_alias`

<a href="https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias">GitHub complete_alias</a>

Next, you'll need to append this file to the bottom of `~/.bash_completion`

Finally, you'll need to add your own alias.

In the example below, we are setting up alias autocomplete for alias `p` which is a symlink pointing to `/usr/local/bin/python3.8`

```bash
[user@host ~$] tail -1 ~/.bash_completion 
complete -F _complete_alias p
```