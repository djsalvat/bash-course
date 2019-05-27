Let's say you have a script you've written which plots the voltage readout versus time for some device.
Further, let's say you have some data acquisition code which writes it to a file where each column is a reading,
and it takes the form "[time] [voltage]".

Now, let's say a colleague sends you a measurement that they want analyzed. Annoyingly, they have sent you two text files,
one with a list of times, and the other with a list of voltages. There are 1000 entries in each.

You have many options here, but pretty much any of them is re-inventing the wheel. One can imagine that, in the many decades of command line computing,
this problem has arisen. In this particular instance, the "paste" command does exactly what we want:

```bash
paste -d' ' times.txt voltages.txt
```

This means "take each line from times.txt, and each line from voltages.txt. Place them side by side on a given line, and put a space between them.
Here the -d flag means "delimiter", and we have chosen a space with ' '.

sort
sort -n
uniq
uniq -c
cut
