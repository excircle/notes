# Connecting To A Remote Linux Host Using SSH on VSCode

</br>
This article goes over the basic steps of generating an SSH key, adding this key in VSCode, and making a remote connection.
</br>

## Step 0: Create a .ssh folder + "config" file

You will need to create a `.ssh` folder and config file.

You can do so with the following commands:

```bash
[user@host ~]$ mkdir .ssh
[user@host ~]$ sudo chown 0700 .ssh
[user@host ~]$ sudo touch .ssh/config
[user@host ~]$ sudo chown 0600 .ssh/config
```

You will create a key in this folder and allow VSCode to edit this `config` file.

## Step 1: Generating an SSH Key

The first step in allowing VSCode to make a remote SSH connection is to generate a remote connection. I use Linux for my machine, so these commands will be native to my operating system. They should also work for OSX as well, but I will post some alternative commands if they don't.

#### Use `ssh-keygen` To Create A Key
```bash
[user@host ~]$ ssh-keygen -t ed25519 -C "your_email@example.com"
> Generating public/private ed25519 key pair.
> Enter a file in which to save the key (/home/you/.ssh/my_example_key): [Press enter]
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]
```

If you are on OSX, you may not have the `ed25519` hashing algorithm available. If so, you should have `rsa` available. The below demonstrates how to use `rsa` instead of `ed25519`.

```bash
[user@host ~]$ ssh-keygen -t ed25519 -C "your_email@example.com"
```

This should be the only command that could differs between Linux and OSX.

If you need to load the key on the commandline for future use, you can use the following command:

```bash
[user@host ~]$ eval "$(ssh-agent -s)"
[user@host ~]$ ssh-add ~/.ssh/my_example_key
```

## Step 2: Obtaining and Using Your Public Key

Once you have generated your SSH key, you'll need to provide the "public key" (the key that the target host will use to prove your key is the right one).

Your public key will end in ".pub" - Our full public key file will be called: `my_example_key.pub`

You can obtain the contents of your public key by running the following command:

```bash
[user@host ~]$ cat ~/.ssh/my_example_key.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHnmiV37RU4dT0C8EgNt7x8g1B+HB8TDfxFp97kd84jd your_email@example.com
```
Make sure you copy the contents of your public key, as they will be pasted into a file in the next set of instructions.

#### Establish Your SSH Key On Target Linux Host

You'll need to login to your target Linux host and ensure that you have the following things. If you don't know how to perform some of these actions, look them up

<ol>
    <li>Create a Linux user on target host</li>
    <li>Ensure that a `.ssh` directory exists under the Linux home directories</li>
    <li>Ensure that `.ssh` directory has permissions set to `0700`</li>
    <li>Ensure file `authorized_keys` exists inside of `.ssh`</li>
    <li>Ensure file `authorized_keys` has permissions set to `0600`</li>
    <li><b>Open and paste the public key contents into this file</b></li>
</ol> 

Once your key content has been pasted, you should be able to SSH FROM the host where the key was created TO the target Linux host.

## Step 3: Install VSCode Plugin: "Remote - SSH"

This guide assumes that you are aware of how to install plugins in VSCode.

An image of the plugin to install is shown below:

![Remote - SSH](https://shawnzhong.com/wp-content/uploads/2019/10/img_5da6c8d2090b3.png)

Once you have this plugin installed, click the green button on the bottom left of the screen. An image of this green button has been shown below:

![Remote - SSH](https://files.readme.io/dc263a2-remote-status-bar.png)

Once you have done this, you will see a window appear in the center of your screen. Select the option which reads `Remote-SSH: Connect To Host`

![Remote - SSH](https://assets.digitalocean.com/articles/vscode_remote_ssh/urOLU4z.png)


Next, Select the option which read: `Configure SSH Hosts...`

Next, select the `config` file that you created in Step 0.

#### Edit your SSH Config File For Remote Connections

The SSH `config` file defines how SSH should behave towards a specific host. You should fille out your config file with the following values.

PLEASE NOTE: The "dummy values" below are denoted with a `$` sign. Please edit the dummy values to reflect the values relative to your own remote hostname and username.

```bash
Host *
    StrictHostKeyChecking no
Host $mydummy.com
    HostName $mydummy.com
    User    $my_dummy_user
    IdentityFile    ~/.ssh/my_example_key
```

Once finished, save this file using VSCode.

## Step 4: Connect To Your Remote Linux Host

Once you have saved this file, you should be able to click the green button on the bottom file and select `Remote-SSH: Connect To Host` to start a connection to your remote Linux Host.

![Remote - SSH](https://assets.digitalocean.com/articles/vscode_remote_ssh/urOLU4z.png)

After you have selected this option, you should see the `HostName` that you listed in the previous step. Select this `HostName` and a new window should open with the connection to the host established.

USE THE NEW WINDOW - NOT THE OLD WINDOW

## Step 5: Open Folder

After your connection has been successfully made, you'll have to provide the full path (in the new window) to the folder that you wish to open.

This can be done using the standard `file>open folder` option for VSCode.

A image has been provided below to show you what that will look like

![Remote - SSH](https://devblogs.microsoft.com/python/wp-content/uploads/sites/12/2019/05/11_WSLOpenFolder.png)

That's pretty much it.

HAPPY HACKING!