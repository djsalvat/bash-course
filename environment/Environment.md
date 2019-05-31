Environment variables those which exist within your current instance of the shell.
Some are referred to by programs to take into account specifics about how your
computer or bash environment is configured. They can also be used by you
to store information such as folders or filenames that you use frequently. Let's define a variable:
```bash
MY_FILE=some_long_ass_directory_name_with_subdirectories_in_it/some_unnecessary_subdirectory/some_long_ass_filename_for_some_file_you_often_refer_to.txt
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
only makes the variable available within your current instance of bash. Using the `export` command:
```bash
export AWESOME_PERSON=ME
```
makes the variable available to shell scripts and other programs executed within the shell, or in subshells.
You can view all of the variables that are currently defined in your environment:
```bash
env | less
```
To do define a variable globally (for all users), you must edit the configuration file /etc/profile.
This requires administrative privileges. Unless you are an actual system administrator, you probably shouldn't do this.

A simple example of a useful environment variable is the PS1 variable.
When you open a new terminal, bash checks this PS1 variable to determine how your prompt should be formatted. Try this:
```bash
export '[\u@\h:\w \d \t]\$ '
```
We can get even fancier with colors. the syntax for changing font colors in bash is awful
-- this is the kind of thing you google, and copy and paste what you want. Try this:
```bash
export '[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[01;31m\]\d \t\[\033[00m\]]\$ '
```
See [here](http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html) for some more discussion about customization.

A more serious example is the PATH variable.
At the terminal, when you type a command, bash has to check whether that command exists,
and must find the executable program in the file system and run it.
It knows where to look because your PATH variable tells it where to look.
The value of $PATH is the explicit name of all directories to search, each separated by a colon.

As an example, let's download a game. There are a couple new commands here.
We'll use the `wget` command which simply expects a filename URL, and downloads it to the current directory.
We are downloading a .zip archive. Conveniently, there is the "unzip" command.
To download the file and extract it, we can do the following:
```bash
wget https://github.com/uuner/sedtris/archive/master.zip && unzip master.zip
```
You will notice we have combined these two commands into one line and separated them with `&&`.
If you don't know what thos does, we leave learning this [as an exercise to the reader](http://bfy.tw/NuIw).

Now, we can go into this new directory and play some tetris:
```bash
cd sedtris-master
bash sedtris.sh
```
What if we want to be able to invoke the game regardless of where we are in the filesystem?
Of course you can always execute the game from anyway by providing an absolute path
to the `sedtris.sh` file. For example:
```bash
bash /home/your_user/sedtris-master/sedtris.sh
```
or wherever the download is located. Better still, we can elevate the status of this game script
and make it act like a built-in command or an installed program using the PATH variable.
Let's make a central location for all of the local executables we wish to be able to invoke.
```bash
mkdir ~/bin
cp sedtris.* ~/bin/
chmod +x sedtris.sh
```
We did a few things here:

* The `~` is a bash short-hand for your home folder.
  In fact, when you use the `~` character, bash checks a variable called HOME to determine
  where your home directory is assigned to be.
  So, all we've done is made a new folder called `bin` in your home directory.
* We copied the necessary files to this new directory -- * is a special character
  that will find any file beginning with `sedtris.`.
* The `chmod` command is used to change file *permissions*.
  It is a generally useful command, and can be used to, for example,
  make a file read-only, make it completely inaccessible to other users, and so on.
  Files are not generally executable by default, and here we want to make
  our game act like an executable so that we can run it like any other program,
  and not have to invoke it as a script with the `bash` command.

Now, all of the files are in their right place, but there is one last step:
modifying our PATH environment variable to add this `~/bin` folder to the
list of places for bash to look for executable commands.
```bash
export PATH=~/bin/:$PATH
```
Then at the command line you should be able to do
```bash
sedtris.sh
```

Now, if you close your terminal and try running sedtris again, it will fail.
We can make this change persist if we add it to our hidden file .bashrc, which is invoked each time we open a terminal.

[More reading](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html)
