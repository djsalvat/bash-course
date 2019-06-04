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
See the [[RegexAwkSed]] lesson for more details about grep. 

You can list all of the aliases currently defined in your environment with
```bash
alias
```

You can get rid of an alias with
```bash
unalias <NAME>
```

### The bashrc file

What happens if you close your terminal and open a new one?
You will find that the aliases you have defined are now lost.
In general, defining an alias (or declaring [[Environment]] variables)
only lasts for the duration of the current shell.
We can, however, make these definitions declared automatically
each time we open a new shell. Upon opening a shell, bash looks
at the contents of the `.bashrc` file located in your home directory.
This is an example of a *hidden file*, which in linux is any file whose name begins with `.`.
There are many other hidden configuration files used by other programs,
and it is worth exploring them. we will see one such example in the [[Remote]] lesson.

### Shell scripting

From the above, we see that an alias is like a "shortcut" for a frequently-used.
What if there is a series of commands we often want to use?
Such a series of commands can be placed into a file known as a *shell script*.
Often times you will see shell scripts with the file suffix `.sh`,
though it should be noted that, unlike in windows, file suffixes are not necessary
and hold no special status in linux.