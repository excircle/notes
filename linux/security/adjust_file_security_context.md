# Finding & Changing Security Context In Linux

In this write up, we quickly go over how to assess the context of a file, and how to change the context if it is not correct.

### How To Determine Context

Use the `-Z` flag with the `ls` command to determine the security context on the file. In the below example, we have a security context of `unconfined_u:object_r:user_home_t:s0` for the file `pic.png`

```bash
[akalaj@server static]$ ls -Z pic.png 
-rwxrwxrwx. akalaj akalaj unconfined_u:object_r:user_home_t:s0 pic.png
```

In this case, the file has the security context for files contained within `home` directories.

Since this file resides in the directory called "static" and not "home" - We need to update the security context to better file where this file is, and how the security context for the file should work.

### Changing The Security Context Of A File

The Linux command for changing the security context of a file is `chcon.`

Much like `chown` or `chmod`, this file accepts command arguments in the form of `chcon $CONTEXT $FILE`

In the below example, we will find a suitable security context for a file by examining the context of a file that was here before our example file `pic.png.`

```bash
[akalaj@server static]$ ls -Z ../pinocchio.jpg 
-rwxrwxr-x. root devs unconfined_u:object_r:httpd_sys_content_t:s0 ../pinocchio.jpg
```

The security context `unconfined_u:object_r:httpd_sys_content_t:s0` suits our needs much better than the context that is for the Linux user's home directory.

Using the `chcon` command, let's update the security context.

```bash
[akalaj@server static]$ sudo chcon unconfined_u:object_r:httpd_sys_content_t:s0 pic.png 
[akalaj@server static]$ ls -Z pic.png 
-rwxrwxrwx. akalaj akalaj unconfined_u:object_r:httpd_sys_content_t:s0 pic.png
```

SUCCESS! We have now adjusted the security context on the file.