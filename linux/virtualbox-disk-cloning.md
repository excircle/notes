# Disk Cloning With VirtualBox

This document details the commands needed to clone a disk for the purpose of changing the disk type.

```bash
VBoxManage clonemedium disk --variant Fixed "/Users/akalaj/VirtualBox/jenkins-test-1/jenkins-test-1.vdi" "/Users/akalaj/VirtualBox/jenkins-test-1/jenkins-clone-1.vdi"
```
