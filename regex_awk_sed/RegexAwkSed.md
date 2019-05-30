# regex

First, let's talk about regular expressions (or regex, or regexp).
If you look at the man page for the "grep" command, which you probably know by now,
you'll see that it refers to the search term as a PATTERN.

# grep

The term "pattern" has a special meaning -- grep (and many other unix commands) match text that
agrees with a certain *logical pattern*, and not just verbatim text.
We have been using trivial versions of these patterns. For example, when we use grep to see if firefox is running

```bash
ps aux | grep firefox
```

we are asking grep: if you see the exact letters f, i, r, e, f, o, x, in sequence,
that is a match. Otherwise, there is no match.

Now, what if we wanted a more sophisticated search? For example, what if we wanted to search, say, a document
for not just any instance of a word only at the beginning or end of a line?
What if we want to find instances of a word followed by any number? What if we want to identify
any word that does not contain certain characters? These more abstract patterns are achieved with regular expressions.
Typically, searches and operations for unix commands are performed on a line-by-line basis.

In such expressions, some characters are *special* -- they are "metacharacters" which are not literally interpreted
and searched for. Instead they are used to instruct the command (say grep) how to search. For example,
the beginning of a line is represented by ^, and the end of a line by $. If you do want to literally search
for these characters, you can escape them with \^ and \\$ (and the \ itself is escaped with \\. Yes, this gets tricky).

An example might help. In this folder we have a royal decree. Let's find all instances of lines that contain the letter "I":
```bash
grep  'I' < royal_decree.txt
```

Important to note here: unlike previous uses of grep, I have used single quotes here. Remember that bash has special characters too:
We don't want bash to interpret our funny characters for its own purposes before passing the string along to the "grep" command as an argument.
Using the single quotes helps protect us against this.

Now, suppose we want to do as suggested above and search for "I" at the beginning of a line:
```bash
grep  '^I' < royal_decree.txt
```
Neat, but you'll notice that it picks up the "IMMEDIATELY". Now, if we only want the word I at the beginning of a line, the single quotes help
```bash
grep  '^I ' < royal_decree.txt
```

Now, let's say we want to filter out this document, except for our king's list of things. As we'll see momentarily, the '-' character
is another regex metacharacter, so we'll need to escape it here. In any case, you should be able to understand the following:
```bash
grep  '^\-\-' < royal_decree.txt
```

It searches for "--" only at the beginning of the line. Note that we'd have an extra unwanted match if we just searched for '\-\-'.

Now, what if we want to search for only certain classes of characters? For example, we only want to find items in the list
that contain either a "p" or an "s" followed by "ears". This is what the [] brackets do for us:
```bash
grep  '^\-\- [ps]ears' < royal_decree.txt
```

We can also specify a range of characters to check within these brackets. This is what the "-" does for us. Say we want to find
any lower case letter followed by "ears":
```bash
grep  '^\-\- [a-z]ears' < royal_decree.txt
```

or any letter, be it lower or uppercase
```bash
grep  '^\-\- [a-zA-Z]ears' < royal_decree.txt
```

Now, what if we want to match a "null" character in addition to the lower or uppercase letters? that is, what if we want to match
"ears" but also "pears". and so on? There are additional meta-characters which demand that a certain number of the preceeding
characters be matched. In this case, we want to match 0 or 1 of the characters in question, in order to match things like
"ears" and "pears". to match 0 or 1 characters, we use the sequence "\?".

*Side note: yes, it's not just a question mark, but an escaped question mark.
This is annoying to me, as some programs that use regex demand that some metacharacters are escaped, while others are not.
On the one hand, it can be difficult to remember; on the other, it is easy to just try both versions of what you want and see which one
is obviously correct. Also, many common programs that leverage regex have good "cheat sheets" online (such as grep, sed, vim, etc...).*

Now, back to where we were. If we want to match 0 or 1 characters, we use the "\?" like
```bash
grep  '^\-\- [a-zA-Z]\?ears' < royal_decree.txt
```

Beyond the "?" metacharacter, one can match 1 or more of the class of characters with +, 0 or more with *, or between any integer m
and another integer n with {m,n}. Again, in grep, these "range" metacharacters are escaped, so if we want to search for
exactly two or three characters followed by "ears", we would do
```bash
grep  '^\-\- [a-zA-Z]\{2,3\}ears' < royal_decree.txt
```

Hopefully you're getting the idea. I won't teach every metacharacter, but hopefully you understand the power of regex.
There are several good references for regex. [Here](http://www.zytrax.com/tech/web/regex.htm), for example.

Sites like these can teach you all of the characters at your disposal, but in the end it isn't useful unless you have
practiced and committed enough of it to memory that you can check the reference manuals or google appropriately
when you wish to execute a search which is beyond your working knowledge.

That said, I will show one other set of metacharacters, as it will be important later. These are the grouping metacharacters (),
and the | which acts like a logical or. So, we can search for all text relevant to peanuts and walnuts, but not brazil nuts,
or hazelnuts, or any other kind of nut. That is, we want to search for "pea" OR "wal" + nut. Now, we can't just use the pattern
'pea\|walnut' because grep cannot know to interpret the second OR option as "wal". We need to mark the border of our two search options.
This is where the grouping characters come in:
```bash
grep  '\(pea\|wal\)nut' < royal_decree.txt
```

**Pop quiz:**

* How might you search for the king's phone number, but not other numbers?
* How might you grep your processes to see if your browser is running, not knowing whether it's firefox, safari, or chrome?

# sed

Now, we are quite familiar with outputting and searching the contents of a file, or searching the result of a command which
is sent to stdout. There are tools at are disposal to not only search, but also to edit files and streams.
Perhaps the most general is the sed command (stream editor). One can write scripts in text files, and in fact do some very
sophisticated and multi-faceted manipulations. We saw this earlier -- "sedtris" was in fact written in sed.
While there is occasion to write sed scripts, we'll focus on one-liners here, and if you wish to explore sed scripting,
see the link at the bottom.

Invoking sed usually looks like
```bash
sed '<SED COMMANDS>' < some_file.txt
```
or
```bash
some_command | sed '<SED COMMANDS>'
```

Here, sed acts in some way on the text coming in, and prints it to stdout.
Of course, you will probably want to direct the output to some modified file.
You can do
```bash
sed '<SED COMMANDS>' < some_file.txt > some_file_modified.txt
```

The redirect operators are left associative, so it will process the file first -- that is, (sed < file) > new_file.

Now we can move on to the actual sed commands. A trivial sed command would be empty
```bash
sed '' < royal_decree.txt
```
which simply does nothing. Now, there are two important modes for sed:
* print each line regardless of whether we have performed an action with sed
* only print each line if it has been modified by sed

It is operating in the first mode, unless the -n flag is used. So, the command
```bash
sed -n '' < royal_decree.txt
```
does nothing, and prints nothing.
The first one that we will learn is the "print" command, or "p".
```bash
sed 'p' < royal_decree.txt
```
This says to "take the line, and print it". Now we see both lines twice -- because we are in the first sed mode,
it always prints the line, and now we are instructing it to print it an additional time.
Commands in sed can be separated with semicolons, and groupped with curly brackets.
If we wanted to triple our fun, we could add another print:
```bash
sed 'p;p' < royal_decree.txt
```

We're getting silly, but hopefully the behavior is clear. Let's move on to something more useful.
The -n flag is useful if we are applying some condition to each line in some way before deciding to act upon it.
In particular, we can -- big surprise -- search for patterns in each line, and only act if we have a match.
So, we have a sort of "if statement" on a line-by-line basis. Let's only print the line if it matches a certain pattern:
```bash
sed -n '/^I/ p' < royal_decree.txt
```
Basically, we have just re-invented the grep command. Now, there is the 'delete' command.
Instead of the above, we can delete lines that contain a match:
```bash
sed '/^I/ d' < royal_decree.txt
```

and I have basically re-invented "grep -v". I left out the -n flag this time -- why?

A more useful command is the 'swap' command. Let's say our king decided
he doesn't want to call them "peanuts" and "walnuts" anymore, but he wants them to be "nutpeas" and "nutwals".
You *could* do a "find and replace" in a typical text editor for each type of nut
 -- but what if we had many, many kinds of nuts for which to make this change?
You can do it in one fell swoop with sed. The 'swap' command looks like s/<MATCH PATTERN>/<REPLACEMENT PATTERN>/[g].
The g at the end is optional -- without it, only the first instance of a match on the line is modified.
With it, all matches on the line are modified. So, let's wrap our minds around this guy:
```bash
sed 's/\(pea\|wal\)nut/nut\1/g' < royal_decree.txt
```

We are matching peanuts and walnuts as before. Now, in the replacement pattern, we have something new:
when you use the \( \) grouping, the match between those delimiters is stored,
and can be used again in the replacement pattern. Each instance of a set of \( \) is assigned an integer starting at 1.
You can place it into the replacement pattern with \1, \2, \3, and so on.
Does the above command make sense now? What does it do?

We could go on, but if you see this as useful, it's better to go to one of the tutorials online, such as the one I link below.
There are many subtle and powerful additional sed commands.
It can be quite tricky to use, but even knowing some of the basic commands can be quite useful
when you find yourself having to tweak or re-format a file of some sort.

# awk

Lastly, there is awk -- the more numerically inclined sibling of sed.
Like sed (and like many commands, as you know by now), it acts line by line on input from a file or stdin.
In particular, awk is meant to perform actions on lines of tabulated information
 -- fields delimited by some common character. Think of it as command line Excel.
As with sed, one can be rather sophisticated, and write sequences of awk commands into files,
and invoke those awk scripts. We'll just focus on the very basic functionality.

```bash
awk '/MATCH/ {AWK COMMANDS} ; /ANOTHER MATCH/ {AWK COMMANDS} ; ...' < some_file.txt
```

The additional matches and commands of course being optional. The match is optional as well. The curly braces are necessary.
The most important feature is that it lets you access each field by its column number.
Column 1 is referenced by $1, column 2 by $2, and so on.
An example will clarify.

Let's take the inverse of the problem we encountered in the [[AdvancedTricks]] lesson.
Let's say we want to _separate_ two columns of data (time, voltage) into two files.

```bash
awk '{print $1}' < voltage_vs_time.txt > times.txt
```
```bash
awk '{print $2}' < voltage_vs_time.txt > voltages.txt
```

We have "print", which is an awk command, and we grab only one column at a time from voltages_vs_time.txt,
and put it into new files times.txt and voltages.txt.

-----------------------------------------------------------------------------

A good tutorial for many unix topics, but in particular awk, sed, and regular expressions:
http://www.grymoire.com/Unix/

In particular I learned a great deal about sed from that site.
