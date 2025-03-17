# How To Disable IPV6 On Debian

Edit the `/etc/sysctl.conf` file and add the following values:

```bash
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.tun0.disable_ipv6 = 1
```

Also ensure that SSH is using an IPV4 address by making sure the following values are uncommented from `/etc/ssh/sshd_config`

```bash
ListenAddress 0.0.0.0
Port 22
```