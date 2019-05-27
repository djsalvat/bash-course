Determining the properties and status of your computer can be achieved with a set of standard utilities.

The general point here is that _there is pretty much a command for everything_.
There were days before graphical user interfaces, and yet every conceivable task could be completed.
It's good to get used to this idea -- this gives you the power to perform tasks quickly, remotely, or in an automated way.

We'll just mention a few examples here; these are standard tools which are quite standard, and discussed ad nauseum on Q&A sites like stack overflow.

If we want to check the size of a file or files, we can use the disk usage command (du):
```bash
du <files>
```

We can force it to present the size in a human readable format with the -h flag:
```bash
du -h <files>
```

If we want to check the usage of all disks attached to the computer, we can use the df command:
```bash
df
```

The amount of space used on each drive is in kb blocks.
As with the du command, we can force it to give us the amount used in a "human readable" format with the -h flag
```bash
df -h
```

We can do something similar with RAM and virtual memory
```bash
free
```
or
```bash
free -h
```

Fixed information about the computer is generally contained in files.
Information about the processor can be found in /proc/cpuinfo:

```bash
less /proc/cpuinfo
```

you can page through, and you will see a list of each processor (i.e. core). If you just wanted to count the number of cores on your machine, you could do
```bash
grep processor < /proc/cpuinfo
```

If you want to see how the network connections are configured, there is the "ifconfig" command. Here, "if" is short for "interface" or "network interface".
```bash
ifconfig
```
There are other "interface" commands, for example ifup and ifdown, to activate or deactivate a particular network connection.

Let this be a terse and unsatisfying survey of some network commands. I must confess I don't know a single good resource for all system-related commands;
my knowledge is a patchwork of commands that I have learned as needed.
