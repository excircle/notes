# How To Install Intel WiFi Drivers On Debian

#### Add The Following Repositories To Apt

```bash
###Inside of /etc/apt/sources.list
deb http://deb.debian.org/debian buster main contrib non-free
deb-src http://deb.debian.org/debian buster main contrib non-free

deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free

deb http://deb.debian.org/debian buster-updates main contrib non-free
deb-src http://deb.debian.org/debian buster-updates main contrib non-free
```

#### Update Repos Using APT

```bash
sudo apt update
```

#### Install Intel WiFi Drivers (firmware-iwlwifi/stable)

```bash
sudo apt install firmware-iwlwifi/stable
```

<b>PLEASE NOTE A RESTART IS REQUIRED</b>

#### Using NMCLI Add Wireless Network

Once you have restarted your system, use `nmcli` to connect to your network.

```bash
user@hostname:~$ nmcli dev wifi connect YOUR_WIFI_NETWORK_NAME password YOUR_PASSWORD
Device 'wlp0s20f3' successfully activated with '0a9931de-78b1-476f-8605-59a9a3b6f4cb'.
```