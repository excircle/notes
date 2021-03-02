# Fixing issues with lsb_release

On 03-02-2021 I ran into an issue where `/usr/bin/lsb_release` wasn't working on my Linux laptop.

During my attempt to install the `gcloud` sdk on Debian Buster, I found that an env variable needs to be created to explain to the installer what OS was being used.

The command was failing as follows:

```bash
user@host:~$ export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
Traceback (most recent call last):
  File "/usr/bin/lsb_release", line 25, in <module>
    import lsb_release
ModuleNotFoundError: No module named 'lsb_release'
```

At first, I thought this was an issue and attempted to reinstall `lsb_release` using the below command.

```bash
sudo apt install http://ftp.us.debian.org/debian/pool/main/l/lsb/lsb-release_10.2019051400_all.deb
```

How ever, Debian Buster quickly told me that the package was already installed.

```bash
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Note, selecting 'lsb-release' instead of './lsb-release_10.2019051400_all.deb'
lsb-release is already the newest version (10.2019051400).
0 upgraded, 0 newly installed, 0 to remove.
```

# What Fixed This Issue?

Fixing Python!

My system came installed with an older version of Python 3.5.

I had upgraded my system to Python 3.8

In upgrading to Python 3.8, I had inadvertently confused my system as to the location of the python file `/usr/share/pyshared/lsb_release.py`

If you look at the `lsb_release` file in `/usr/bin/lsb_release` you'll see that it's a Python file.

<b>EXAMPLE: `/usr/bin/lsb_release`</b>

```python3
#!/usr/bin/python3 -Es

# lsb_release command for Debian
# (C) 2005-10 Chris Lawrence <lawrencc@debian.org>

#    This package is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; version 2 dated June, 1991.

#    This package is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this package; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
#    02110-1301 USA

from optparse import OptionParser
import sys
import os
import re

import lsb_release
```

`import lsb_release` searches for the file `/usr/share/pyshared/lsb_release.py`.

After doing some Googling to confirm, I found the following stack overflow link which correctly advised that I create a symlink to the previous Python `lsb_release.py`

If you care to read up on the solution, the link is here: https://stackoverflow.com/questions/46752279/lsb-release-not-working-after-install-python-3-6-3-from-source

# Actual Solution

The actual solution to this problem is to create a symlink for this older `/usr/share/pyshared/lsb_release.py` file.

The command to do this for Python3.8 is below:

```bash
sudo ln -s /usr/share/pyshared/lsb_release.py /usr/local/lib/python3.8/site-packages/lsb_release.py
```
