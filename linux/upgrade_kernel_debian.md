# Setup Debian repo hosting latest kernel image

```bash
echo "deb http://deb.debian.org/debian buster-backports main" > /etc/apt/sources.list.d/kernel.list
```

# Update apt to regard newly added repos

```bash
apt update -y
```

# Upgrade Kernal using apt

```bash
apt -t buster-backports upgrade -y
```