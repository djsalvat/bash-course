TARS AND TARBALLS

The tar command (tape archive) combines files into a single file in a reversible way.
This combined file can optionally be compressed using gzip, bzip, or other compression methods.

Some common flags to go with the tar command:
* 'x' for extract
* 'v' for verbose (this tells you each file it's unpacking. I basically always do this)
* 'z' if the file is, or should be, gzip compressed
* 'f' means that we are about to specify the filename (here 'some_file.txt')

Convention states that tarballs end in .tar.
If they are compressed, they have another suffix -- for example .tar.gz for gzip compressed files.

Zip some files to a new folder
```bash
tar -cvzf new_file.tar.gz *.dat
```

List files in a tarball
```bash
tar -tvzf new_file.tar.gz
```

Unzip a compressed tarball
```bash
tar -xvzf new_file.tar.gz
```

Here is an [interesting read](http://blog.extracheese.org/2010/05/the-tar-pipe.html).
