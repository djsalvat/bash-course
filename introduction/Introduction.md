# Why are you here?

These lesson pages are intended to be an introductory walkthrough of command line usage.
For the aspiring experimentalist, some familiarity with the command line is unavoidable.
I would argue that mastery of the command line will only make your life easier:
it will reveal to you tools for performing tedious and mundane tasks with relative easy,
and give you the power to automate or simplify a number of tasks that would otherwise amount to monotonous, time-consuming labor.
Much of the power of the command line revolves around efficiently interacting with files and folders
on your computer, and facilitating the advanced manipulation of streams of data and text.
Consider the following examples.

**Example 1:** Another graduate student in your group gives you an analysis script or program which reads a text file
containing a collated list of voltages versus time: that is to say, a text file
with each row being a time followed by a space character, followed by a voltage.
Perhaps this is a measurement of the amplitude of an oscillator,
a measurement of a radio-frequency signal, or a digitize waveform of a particle detector.
The next day, your advisor, who annoyingly has their own means of analysing these data,
provides to you with two text files: the first is a file with a single line containing
30000 time measurements separated by commas. For example, "0.0, 0.2, 0.4, 0.6, 0.8, " and so on.
The second file is, unsurprisingly, a file with one line of voltage measurements
at times that are collated with the other file. How do you proceed?

* Do you read the source code for the analysis provided by your fellow student, and modify
  it to read your advisor's data?
* Do you write some custom program in your preferred programming language to convert the formats?
* Do you import into Excel and find some means of reconciling the formats?
* Do you drop out of graduate school and start a podcast?

Here we will learn that none of the above options are preferred, except perhaps for the last one.
Indeed, if we are given these two files which are named, say, `times.txt` and `voltages.txt`, three commands solves the problem:
```bash
sed -i 's/, /\n/g' times.txt
sed -i 's/, /\n/g' voltages.txt 
paste -d' ' times.txt voltages.txt > time_vs_voltage.txt
```
This will leave you with a single text file conforming to the format required by the original script.
If this does not look like gibberish to you, then you probably do not need to continue with this walkthrough.

**Example 2:** The IT administrator at your university sends you a nasty e-mail complaining that your
linux machine or virtual environment is taking up too much disk space on the server.
You are obliged to reduce your disk space, but as far as you can recall, you have no large files.
Moreover, your home directory contains many folders within folders.
You want to solve the problem by finding any file larger than, say, 100MB. This is simple:
```bash
find ~/ -size +100M
```

# Let's start

### Getting around
I must take as a given that you have arrived at a command line on sme sort of linux, BSD, or OSX-like environment.
Upon opening such a terminal, you are given a *prompt* at which you can input a command and press <Enter> to execute that command.
Within this prompt you are, at any given time, executing said command within a given folder on your computer.
As a default, this is typically the `home` directory for your username.
For example, if you open a terminal whose default is indeed your home user directory and invoke:
```bash
ls
```
it will provide you with a list of the contents of this directory.
When issuing a command that prints information back to the terminal,
we say that that the command prints to "standard out", or `stdout`.
This is a stream of data that, unless we chose to direct somewhere,
will ultimately print to our screen. There is similarly an input stream `stdin`.

We will want to be able to change directories. Let's make a new directory and move into it (or "change directory"):
```bash
mkdir new_directory
cd new_directory
```
If you issue the `ls` command once more, you will notice that it returns nothing. Indeed, our new folder is empty.

### Using standard input and output

As they say, in linux *"everything is a file"*. Devices, logs, information, settings,
are generally represented by or stored in files that you can interact with at the command line.
For example, for those using linux, you can find information
about your computer's processor in the file `/proc/cpuinfo`.
For those using another operating system, I have provided an example cpuinfo file in `introduction/cpuinfo`.
We can print the contents of a file to `stdout` using the `cat` command:
```bash
cat /proc/cpuinfo
```
Now, the `cat` command is short for "concatenate", and it is intended to be used to, unsurprisingly,
concatenate multiple files and send them to `stdout`. Here we use it trivially for one file.

Displaying a file in this way is a bit annoying if the file has many lines. Luckily there is the `less`
command, which acts as a reader that allows us to scroll.
```bash
less /proc/cpuinfo
```
You can press `q` to quit and return to the command line.

Now, here is the core of this lesson. The `less` command can also accept a stream of text from `stdin`.
What if, for example, we have a folder with many files, and issuing `ls` gives us a long list
of files and folders we wish to page through using `less`?
We need a means of taking the information sent to `stdout`, and directing it to `stdin` for `less` to use.
You might say we need to "pipe" the `ls` command into `less`.
This, in point of fact, what a *pipe* does. Let's see it in action:
```bash
ls | less
```
This does exactly what we need -- the output of `ls` is directed to the input of `less`.
Pipes are an extremely important component of command line mastery, and we will employ them often here.

Further, what if we want to send  stdout into a file? This can be done with a *redirect* using the `>` character.
We can save the output of the `ls` command to a file:
```bash
ls > a_list_of_files.txt
```
Similarly, one can draw a file's contents into stdin via `<`.

It is important at this point to note that redirects must be used with the utmost care:
**a redirect to an existing file will overwrite the contents of that file** --
a process known as *clobbering*. This behavior can be changed by customizing your bash environment.
Instead of just writing to a file, we can also append to a file with `>>`.

### Flags

Commands often have optional configuration that can be changed by issuing *flags*.
Typically these are in the form of additional characters or key words prefixed with dashes
after the command itself. For example, try:
```bash
ls -lart
```
What does that do?

### Help you help yourself

Suppose you want to learn the answer to the previous question,
and learn what other potentially useful flags the `ls` command has.
Built in commands and many other common commands have manuals, or *man pages*.
The `man` command will find and display the manual for such a command:
```bash
man ls
```

The behavior and customization of commands, as well as discussion of best command line practice,
is discussed at length on websites such as [stack overflow](http://stackoverflow.com).
It pays to habitually read man pages and perform internet searches to ask questions.
BASH, for example, has been around for about thirty years, and the answers to a great majority of questions
that you have can be readily found.
