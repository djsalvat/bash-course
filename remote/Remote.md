Functional knowledge of the command line makes interacting with remote computers that much easier.
One can use remote desktop programs, but often times this is not possible or practical.
For a given remote machine (I'll be using somehost.domain), and user (dknotts),
we can use ssh -- "secure shell", which provides you, the user, an encrypted terminal on that remote machine.
We connect via
```bash
ssh dknotts@somehost.domain
```

And now your prompt (whatever $PS1 is set to on the remote machine) will tell you that you are connected remotely.
If you quit this terminal (e.g. $ exit), you will disconnect from the remote machine and return to the terminal from which you executed the "ssh" command.
Alternatively, you can send individual commands to the remote machine, by providing the command(s) as an argument:
```bash
ssh dknotts@somehost.domain 'echo AAAAAAAAUUUUUUUUUUUUUUUUUUUGH'
```
This will connect to the remote machine and yell on it.

Like any command line workhorse, ssh has a number of flags to enhance or modify its behavior. A particularly useful example is the -X flag (and related -Y flag -- read the man page!).
This flag configures the connection so that remote X windows will be displayed on your local machine.

In practice, most users want to connect to a remote server on a regular basis. To make this more convenient, one can use aliases, or set this host and/or username as environment variables in .bashrc such as
```
export SOMEHOST=somehost.domain
export SOMEUSER=dknotts
```
A nice consequence being that you can tab-complete the variable names SOMEHOST and SOMEUSER. Then, connecting would connect with
```bash
ssh $SOMEUSER@$SOMEHOST
```

Better still, we can leverage the power of configuration files. SSH can be configured for you, the individual user,
by adding this username and host to ~/.ssh/config (creating the config file if it doesn't exist).
We would add to this file the following:
```
Host somehost 
    HostName somehost.domain
    User salvat
    ForwardX11 yes
```
Here, each line consists of a configuration parameter followed by the value we want to set. Here I have decided to nickname my remote machine to be "somehost".
The indented lines are to specify that the following options pertain to this host in particular.
The "ForwardX11" option is equivalent to setting -X, as discussed above.
Then we can
```bash
ssh somehost 
```

Now, if we want to make our local machine aware of this host for all users, this is where our knowledge of the layout of linux is useful.
We can edit the file /etc/ssh/ssh_config.
There is a theme here -- system-wide configuration files tend to be found in /etc/.
This is the point where I mention to only edit these files if you need to, and proceed with caution.

Finally, one might want the convenience of passwordless login to commonly-used remote machines.
This is achieved by generating a public key, and copying that public key to the remote machine.
Then ssh can check that the keys match. This does have security implications.
If someone maliciously gains access to your local /home/ directory, they only need to grab a copy of this key,
and then they will have access to any such remote machine as well.

The below discussion does rely on the process "ssh-agent" running on the remote machine.
For sufficiently new OS versions, this will probably work, but see the further reading if not working.

First, we must generate the key. This key will get stored in a file (which we can specify, but it is in ~/.ssh/id_rsa by default.
Important warning here -- if you have already configured this, don't do these next steps, or you'd screw up the configuration you already have.

That is, BE SURE THAT YOU HAVE NOT ALREADY GENERATED SUCH A KEY AND STORED IT IN ~/.ssh/id_rsa.
If you have already done so, you probably don't need to be reading this part of the tutorial anyway.

Now, we'll create a key using the "digital signature algorithm" (DSA).
```bash
ssh-keygen -t dsa
```
Here, the '-t' flag tells ssh-keygen that we are specifying the algorithm to be used.
You will be prompted for a place to save this key. If you simply press enter, it will save to its default location (probably .ssh/id_rsa).
You will then be prompted for a password. If you want to facilitate passwordless login, you can leave this blank (i.e. just press enter again).
Alternatively, you can provide a password. Then, any machine to which you give the key will expect this password -- a sort of master password.

Once you have generated this key, you must copy it to your home directory on $HOST.
Many modern machines come equipped with a command to do this for you, with relative safety and ease:
```bash
ssh-copy-id dknotts@somehost.domain
```
or if we've configured things nicely as above,
```bash
ssh-copy-id somehost 
```

Now, if the command ssh-copy-id is not available, we can copy the key ourselves. There's a lot to unpack about this statement:
```bash
cat ~/.ssh/id_rsa.pub | ssh somehost 'mkdir -p ~/.ssh && cat >> .ssh/authorized_keys && echo "Key copied"'
```

Finally, we'll mention rsync. It provides a fast means of copying data.
It is superior to 'cp' in that it keeps a record of what has been copied between two locations,
checks for differences, and if there has been a change in the source directory,
it only needs to copy the difference to the target directory to complete the operation.
This makes it nice for backup. It isn't strictly a remote command, but is often used for remote backup.

Here is some [further reading](https://support.suso.com/supki/SSH_Tutorial_for_Linux).
