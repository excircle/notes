# How To Create Passwordless Sudo User

Add the following entry into your `/etc/sudoers` file using the command `sudo visudo`

```bash
# User privilege specification
root	ALL=(ALL:ALL) ALL
akalaj  ALL=(ALL) NOPASSWD: ALL
# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL
```