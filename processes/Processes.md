When a program is executed, it becomes a "process". You can view currently running processes with the "ps" command.
```bash
ps
```
You will probably see two processes: "bash", and "ps". The former because the instance of your current command line interpreter (bash) is,
after all, just another computer program. The latter because ps itself is also just another program which is called and executed.

Now, this isn't very helpful -- this is simply showing you the processes tied to your current terminal.
Of course, the "ps" command has numerous flags to change its behavior and can provide a lot of information. In practice,
I only ever remember one command:
```bash
ps aux
```
This shows all system processes and who owns them. It is a lot of information -- hopefully by now you would know to do a
```bash
ps aux | less
```
to browse the output. You'll see several columns, labeled at the top: the user who owns the process, a "process ID" (PID),
the CPU and memory usage, virtual and physical memory allocated (that's the VSZ and RSS I believe), as well as the time of execution.
There is also the "TTY" field, which shows from which command line terminal the command was executed, if applicable.
We'll mention processes which are not tied to a terminal below.
There are still other fields that one can choose to print through the ues of additional flags passed to the command.
These are all listed in the man page under "STANDARD FORMAT SPECIFIERS".

On that note, let's learn how to search a man page. You'll open the man page:
```bash
man ps
```
and once viewing the page, press the forward-slash key on your keyboard (/), type the search term, and press the enter key.
So, typing `/STANDARD FORMAT SPECIFIERS<Enter>` should skip you to the first instance of this term.
Sadly, if your man page looks like mine, it will find an instance of this section being referenced in an earlier section.
In order to skip to the next match of your search, press "n" on the keyboard -- this should get you there.
As an aside, typing instead shift+n searches backwards in the file.

Now, you might be looking to see whether a particular process is running. If your browser is, say, firefox,
and you have the browser open, you could try
```bash
ps aux | grep firefox
```
which should return a result or results. In fact, there is a command to search processes directly
```bash
pgrep firefox
```

There are many additional flags that can be passed to pgrep to provide any information you might want.
Frankly, I never remember the flags, and opt to just do "ps aux | grep" instead. Because that's how I feel.

Finally, if you want a real-time updating list of processes, you can use top
```bash
top
```

Now, say you have a process which you can't currently interact with, but you want to stop. If you have run ps and determined the PID,
you can do
```bash
kill <PID>
```
or you can use the more sophisticated "pkill" which allows one to identify and kill processes based on name and other properties.
If the process has completely frozen, the kill command might not succeed. You can force it to be killed by passing it the "SIGKILL" signal,
which happens to be represented by the number "9". Specifically, you would do
```bash
kill -9 <PID>
```
This command might seem strange, and the "9" has to do more generally with the way signals work, and how they are represented at the command line.
[Here](http://stackoverflow.com/questions/9951556/why-number-9-in-kill-9-command-in-unix) is a good place to start.

Programs invoked from bash either run in the foreground or background. You are probably used to them running in the foreground:
the program blocks further interaction with the command line, and takes control until its execution is complete.

If we run the script in this folder
```bash
./remind_me_im_awesome.py
```
you'll see that it just keeps on reminding you. It is running in the foreground, and you are "blocked" from interacting with bash until
it is done, or we stop it. This script keeps looping forever, so we must stop it. This is accomplished with ctrl+c.

Instead, we can suspend the process (i.e. pause it) with ctrl+z. You'll see a line in the terminal starting with [n] where n is some integer (probably 1).
This is not a PID for the program, but a "jobspec" number, which is an identifier unique to bash.
Now, the program is waiting for your signal to keep going, and it frees up the command line. We can either resume it with the "fg" command.
```bash
fg 1  #here "1" is the jobspec number
```
Instead, we could have resumed it in the _background_, so that it continues running, but we maintain access to the command interpreter.
```bash
bg 1
```

Now, the program is still writing to stdout while we are trying to type in new commands. Further still, ctrl+c doesn't stop it.
It's in the background, so we aren't talking directly to it. You could use pkill, or look up its PID and kill it.
Or, you can bring it foreward again by typing

```bash
fg 1
```
at which point ctrl+c should work. If we want to start a command running in the background from the start, you add " &" at the end of your command:
```bash
./remind_me_im_awesome.py &
```
It will again give you the jobspec number in brackets, and you can bring it forward and kill it. Now, what if we don't actually need to see
the output of the program while it runs in the background? Remember, "print"ing simply sends data to stdout, which appears in our terminal.
We can _redirect_ the output to, say, a file
```bash
./remind_me_im_awesome.py > remind_me_later.txt &
```
Or, we can use a certain special file in linux -- /dev/null. It is the file that leads nowhere, and what is sent to it is thrown away.
```bash
./remind_me_im_awesome.py > /dev/null &
```
If we check with ps
```bash
ps
```

you will see that our program is in fact running. The computer brain is taking the time to write our reminder to stdout, direct it towards /dev/null,
and forget about it. Now, because it is tied to our terminal, we can of course bring it to the foreground and kill it as before.
This works because processes executed in the command like are generally tied to the command line terminal (it is the parent of the process).
Run our reminder in the background again, and you can use the pstree command to see parend child relationships for processes.
Running our reminder, doing a
```bash
pstree | less
```
and searching (with "/") for "remind" should take you to a line that looks something like
```
     |      `-bash-+-less
     |             |-pstree
     |             `-remind_me_im_aw
```

So, we've got a process called "bash" which is running less in the foreground, fed from "pstree", but is also running "remind_me_im_aw...".
The reminder script process, in a way, "belongs" to this bash process. If we were to close our command terminal window, its child processes
will generally die with it.

This leads to one last point -- how do we start a process which is not bound to the current terminal?
Such processes are called daemons. We can accomplish this with the "nohup" command (short for no hangup, I believe).
To test this, open up a second command line window. Navigate to the directory with the reminder script, and do
```bash
nohup ./remind_me_im_awesome.py > /dev/null &
```
Now, search for it using ps. Under the "TTY" field, you will see a terminal address -- it is currently tired to a terminal.
The nohup command makes it persist after the terminal is gone; now, just close this second terminal window in which you have
executed the script. Try looking for it with ps again -- you'll see the TTY field reads "?". So, the script is in fact still
chugging along. You'll have to kill it with "kill" now.
