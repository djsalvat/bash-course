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

**Example 2**: Example for replacing filenames? or perhaps changing in-place some formatting error?

**Example 3:** The IT administrator at your university sends you a nasty e-mail complaining that your
linux machine or virtual environment is taking up too much disk space on the server.
You are obliged to reduce your disk space, but as far as you can recall, you have no large files.
Moreover, your home directory contains many folders within folders.

**Example 4:** Some example for automation/crontabs/repeated command entries/customization?

# Let's start

I must take as a given that you have arrived at a command line on sme sort of linux, BSD, or OSX-like environment.
Upon opening such a terminal, you are given a `prompt` at which you can input a command and press <Enter> to execute that command.
Moreover, you are, at any given time, executing said command within a given folder on your computer.
As a default, this is typically the `home` directory for your username.
For example, if you open a terminal whose default is indeed your `home` user directory and invoke:
```bash
ls
```
it will provide you with a list of the contents of this directory.
