# List Running & Non-Running VMs

```bash
 vboxmanage list vms
 vboxmanage list runningvms
```

# Show Specific VM Info

```bash
vboxmanage showvminfo $VM_NAME
```

# Clone existing VM

```bash
vboxmanage clonevm "$TARGET_VM_NAME" --name "$VM_NAME" --basefolder="/Users/akalaj/VirtualBox/$VM_NAME" --register
```

# Delete existing VM

```bash
vboxmanage unregistervm $VM_NAME --delete
```

# List VDIs

```bash
vboxmanage list hdds
```

