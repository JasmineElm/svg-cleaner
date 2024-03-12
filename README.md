# svg-cleaner

svgo and vpype are excellent tools, but I struggle to remember the commands and
how to install them. This is a simple wrapper around  both with a few defaults that I find
useful.  

## Installation

The only requirements for installation are `Python3` and `pip`, you're on your own
for those, but can probably get them using package manager, e.g., 

+ Debian: `sudo apt-get python3 python3-pip`
+ MacOS: `brew install python3 python3-pip`

Once you have those, there is a [bash script](setup.sh) that will install a virtual
environment containing both tools; you will activate the virtual environment to
use both, but you won't be stuck with global installs if you decide this isn't
for you.

