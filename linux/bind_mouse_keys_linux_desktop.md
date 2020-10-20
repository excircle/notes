# How to bind F keys to things in Linux

### 1.) Installed the following packages:

```bash
sudo apt install x11-utils xbindkeys xautomation
```

#### 2.) `x11-utils` provided `xev` which I used to click the mouse and identify "button8"

```bash
[akalaj@lifenode:~ $] /usr/bin/xev
    ButtonRelease event, serial 34, synthetic NO, window 0x800001,
    root 0x191, subw 0x0, time 77610275, (18,2078), root:(2582,2098),
    state 0x10, button 8, same_screen YES
```

#### 3.) Then I used `xbindkeys` to create and populated a shortcut file

```bash
[akalaj@lifenode:~ $] cat ~/.xbindkeysrc 
# Bottom button
"xte 'key F11'"
     b:8
```

#### 4.) `xte`  from the `xautomation` package then runs the F11 key.

Following `xbindkeys` commands were needed to load/reload config:
```bash
killall -s1 xbindkeys
xbindkeys -f ~/.xbindkeysrc
```

LINUX LAPTOP FOR LIFE!
