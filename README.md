# svg-cleaner

svgo and vpype are excellent tools, but I struggle to remember the commands and
how to install them. This is a simple wrapper around  both with a few defaults that I find
useful.  These should be installed in a virtual environment to avoid conflicts
and to make it easy to remove them if you decide you don't like them; removing
the virtual environment will remove both tools.

## Installation

The only requirements for installation are `Python3` and `pip`, you're on your own
for those, but can probably get them using package manager, e.g., 

+ Debian: `sudo apt-get python3 python3-pip`
+ MacOS: `brew install python3 python3-pip`

Once you have those, clone this repo and run [setup](setup) which will install a virtual
environment containing both tools.

## Usage

If you simply want to use the tools, you can activate the virtual environment:
`source .venv/bin/activate`.  The motivation however, is to make it easy to
quickly clean up a directory of `.svg` files.  To that end,
the [clean](clean) is provided. It reads
parameters from two config files: `svgo.config` and `vpype.config` which set
"sensible" defaults for the tools. To change these defaults, simply update the
relevant config/s.

The `clean` script takes a single argument, a path or file name. If the
argument is a path, it will recursively search for `.svg` files and process them.


**Woah, this is slow!**
Yep.  Yes it is.  Part of this is the overhead of invoking the virtual
environment, combined with the calls to both vpype and svgo.  I'm sure there are
optimisations to be made here, I'll get around to them.  The main focus is to
get it "right" and then "fast".  Please consider this alpha quality software;
I'll tag the first release when I'm happy with it.

