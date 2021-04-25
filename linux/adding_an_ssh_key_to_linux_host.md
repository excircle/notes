# Adding An SSH Key To A Linux Houst

This doc quickly goes over the process of generating an SSH key and then adding that key to a Linux host.

The steps featured here will show the process of generating a key on a Macbook Pro, then adding that key to a remote Linux host.

## Generating A SSH Key

Open a terminal, then enter the following `ssh-keygen command`. The example also shows the key being created into file `bigdata`

```bash
ssh-keygen -t ed25519 -C "unixdisciple.us@gmail.com"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/Users/akalaj/.ssh/id_ed25519): /Users/akalaj/.ssh/bigdata
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/akalaj/.ssh/bigdata.
Your public key has been saved in /Users/akalaj/.ssh/bigdata.pub.
```

## Obtain Public Key, Add To Auth File

On your Macbook, expose the public contents of the file you created by using the `cat` command.

```bash
cat ~/.ssh/bigdata.pub
ssh-ed25519 EXAMPLEzaC1lZDI1NTE5BBBBIPmWdEuBLDw7Q33jxNG1aqh65etu9gc7hLAMtXbYwI5h unixdisciple.us@gmail.com
```

If a Linux system is setup to work with SSH, the home directory for a given user should have a `.ssh` folder where auth configuration and data can be kept.

For our use case, we're looking to identify an auth file contained within this directory.

On your remote Linux host, open the file `~/.ssh/authorized_keys`

```bash
vim ~/.ssh/authorized_keys
```

Add the output from our cat command to the bottom of the `~/.ssh/authorized_keys`

## Log In Using The SSH Command

Once you have appended the SSH key to the bottom of the authorized keys file, use the below SSH command to log into the host.

```bash
ssh -i /Users/akalaj/.ssh/bigdata example.bigdata.co
```

# VICTORY!