# How To Install Golang 1.15 From Debian Repos

```bash
echo "deb http://ftp.de.debian.org/debian buster-backports main" > /tmp/debian-buster-backports.list
```

# Move to APT directory

```bash
mv /tmp/debian-buster-backports.list /etc/apt/sources.list.d/
```

# Update APT

```bash
sudo apt update
```

# Install Golang 1.15

```bash
sudo apt install golang-1.15* -y
```