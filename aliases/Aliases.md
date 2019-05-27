Aliases are instructions to bash to replace text with other text prior to executing the command. Aliases are defined like

```bash
alias NAME=STRING
```
where STRING is generally a command or some combination of commands. Some examples:

Define "lsl" to be a soupped up version of ls
```bash
alias lsl='ls -lhFA | less'
```

In redhat/scientific linux, make it a bit easier to search for and install programs
```bash
alias dowant='sudo yum list'
alias canhaz='sudo yum install'
```

Get rid of the pesky root splash screen by default
```bash
alias root='root -l'
```

Search for commands in your history by making up your own "hgrep" command
```bash
alias hgrep='history | grep'
```

You can list all of the aliases currently defined in your environment with
```bash
alias
```

You can get rid of an alias with
```bash
unalias <NAME>
```

Note:
* they only live as long as your terminal instance. For them to persist, put them in .bashrc. See the 'environment' folder.
* Aliases don't work in shell scripts. Type out the full commands in the script instead.
