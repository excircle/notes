# Upgrading CentOS To Mainline Kernel

The following bash commands will allow you to download and install the latest mainline linux kernel

```bash
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm 
sudo yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
sudo yum --enablerepo=elrepo-kernel install kernel-ml
sudo yum install vim -y
sudo vim /etc/default/grub 
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo yum remove $(sudo yum list installed | grep kernel | grep 10 | awk {'print $1'}) -y
sudo shutdown -r now
uname -r
sudo yum list installed | grep "3\.10"
sudo yum remove kernel.x86_64
```
