Environment variables are variables that exist within your current instance of the shell.

You define variables like:
```bash
MY_FILE=has_anyone_been_so_far_as_to_do_want_look_more_like.dat
```

In bash, the dollar-sign character is special, and $BLAH means "replace this expression with the value of the variable BLAH".
```bash
echo MY_FILE
echo $MY_FILE
```
These are not the same. What happens if you put $MY_FILE in double quotes? What about single quotes?

Many commands and programs check the values of different environment variables, and configure themselves accordingly.

Doing a
```bash
AWESOME_PERSON=ME
```
only makes the variable availabie within your current instance of bash.
```bash
export AWESOME_PERSON=ME
```
makes the variable available to shell scripts and other programs executed within the shell, or in subshells, for you alone.

You can view all of the variables that are currently defined in your environment.
```bash
env | less
```

To do define a variable globally (for all users), you must edit the configuration file /etc/profile.
This requires administrative privileges. Unless you are an actual system administrator, you probably shouldn't do this.

A simple example is the $PS1 variable. This variable tells bash the format of your prompt -- you can tweak this and make it pretty. Try this:
```
export '[\u@\h:\w \d \t]\$ '
```
We The syntax for changing font colors in bash is awful -- this is the kind of thing you google, and copy and paste what you want. Try this:
```
export '[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[01;31m\]\d \t\[\033[00m\]]\$ '
```
See [here](http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html) for some more discussion

A more serious example is the $PATH variable. When you type a command, bash has to check whether that command exists,
and must find the executable program in the file system and run it.
It knows where to look because you tell it where to look with the $PATH variable.
The value of $PATH is the explicit name of all directories to search, each separated by a colon.

In this directory, we have a shell script to play tetris. Let's say we want to make it a command.
Make a new folder ~/bin/, put the script in there, and add ~/bin/ to your $PATH.
```bash
mkdir ~/bin
cp sedtris/sedtris* ~/bin/
export PATH=$PATH:$HOME/bin
```

Then at the command line you should be able to do
```bash
sedtris
```
Now, if you close your terminal and try running sedtris again, it will fail.
We can make this change persist if we add it to our hidden file .bashrc, which is invoked each time we open a terminal.

[More reading](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html)
