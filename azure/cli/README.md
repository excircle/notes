# Azure CLI Commands

This document contains notes which outline how to perfom various things using he `az` cli tool from Microsoft.

# Table of Contents

<details><summary>List Accounts</summary>
Use the following command to show what Azure accounts you have access to<br><br>

```bash
az account list
```
</details>

<details><summary>Check Azure VM Images</summary>
Use the following command to show what Azure VM Images are available<br><br>

```bash
➜ az vm image list --output table
You are viewing an offline list of images, use --all to retrieve an up-to-date list
Offer                         Publisher               Sku                 Urn                                                             UrnAlias             Version
----------------------------  ----------------------  ------------------  --------------------------------------------------------------  -------------------  ---------
CentOS                        OpenLogic               7.5                 OpenLogic:CentOS:7.5:latest                                     CentOS               latest
debian-10                     Debian                  10                  Debian:debian-10:10:latest                                      Debian               latest
flatcar-container-linux-free  kinvolk                 stable              kinvolk:flatcar-container-linux-free:stable:latest              Flatcar              latest
openSUSE-Leap                 SUSE                    42.3                SUSE:openSUSE-Leap:42.3:latest                                  openSUSE-Leap        latest
RHEL                          RedHat                  7-LVM               RedHat:RHEL:7-LVM:latest                                        RHEL                 latest
SLES                          SUSE                    15                  SUSE:SLES:15:latest                                             SLES                 latest
UbuntuServer                  Canonical               18.04-LTS           Canonical:UbuntuServer:18.04-LTS:latest                         UbuntuLTS            latest

➜ az vm image list --offer debian-10 --output table
Offer      Publisher    Sku    Urn                         UrnAlias    Version
---------  -----------  -----  --------------------------  ----------  ---------
debian-10  Debian       10     Debian:debian-10:10:latest  Debian      latest
```
</details>


<details><summary>List Regions</summary>
Use the following command to show what Azure regions are available<br><br>

```bash
➜ az account list-locations -o table
DisplayName               Name                 RegionalDisplayName
------------------------  -------------------  -------------------------------------
East US                   eastus               (US) East US
East US 2                 eastus2              (US) East US 2
South Central US          southcentralus       (US) South Central US
```
</details>

