### Aliases

Aliases are instructions to bash to replace text with other text prior to executing the command. For example:
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

For those that use ROOT, we can get rid of the pesky root splash screen by default
```bash
alias root='root -l'
```

You can search for commands in your history by making up your own "hgrep" command
```bash
alias hgrep='history | grep'
```
See the [[RegexAwkSed]] lesson for more details. 

You can list all of the aliases currently defined in your environment with
```bash
alias
```

You can get rid of an alias with
```bash
unalias <NAME>
```

### Shell scripting

### The .bashrc file
