# Vault Implementation Outline For Synchrony Financial

This document is meant to outline the implementation procedure for HashiCorp Vault with Synchrony Financial.

The installation steps described below are itemized in sequential order and reflect HashiCorp implementation engineering's perspective on what steps require administrative access, as well as which steps may be delegated to Synchrony internal services teams.

These steps mirror the installation processed outlined in HashiCorp's provided Ansible playbook and have been reviewed for accuracy by HashiCorp implementation engineer Alexander Kalaj.

# Clarification On Terminology

In the installation steps below, there are 2 columns which speak to aspects of the installation process.

*'Requires Admin':* This column denotes an installation step that will require `sudo` or "sudo-like" privileges, typically for giving permissions and access to the Linux user `vault` from a Linux primary user such as `ekms`.

*'One-Time Operation':* This column denotes an installation step which does not need to be performed after the initial setup of Vault on a given virtual machine. Ansible code can be configured to skip these steps if the installation objective is already completed (Example: if file permissions are already as they should be).

*'METHOD TBD':* "Method to be determined." This denotes a installation step, whose exact procedure remains to be determined by Synchrony engineers. HashiCorp has included recommendations below, but will ultimately defer the exact methodology to Synchrony engineers.

# Vault Installation Steps

| Step  | Task | Unix command | Requires Admin | One-Time Operation |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| 1  | Create Vault Group  | `groupadd vault`  | YES  | YES  |
| 2  | Create Vault User  | `useradd vault` | YES | YES  |
| 3  | Create Vault Directories  | `install -m 0750 -o vault -g vault -d $vault_directory` | YES | YES  |
| 4  | Copy Vault Binary  | METHOD TBD | UNKNOWN | NO  |
| 5  | Create Vault TLS Directory  | `install -m 0750 -o vault -g vault -d ${vault_home_directory}/tls` | NO | YES  |
| 6  | Copy Vault TLS certs  | METHOD TBD | UNKNOWN | NO  |
| 7  | Provision Vault License File  | METHOD TBD | UNKNOWN | NO  |
| 8  | Provision Vault Configuration Script  | `cat > $vault_config_file <<EOF $contents EOF` | NO | NO |
| 9  | Provision Vault `systemd` service file  | `/lib/systemd/system/vault.service` provided by Synchrony Unix team | NO | YES |
| 10  | Enable Vault To Start On Boot  | `sudo systemctl enable vault` | YES | NO |
| 11  | Start Vault  | `sudo systemctl start vault` | YES | NO |

# Notes On Admin Access Required

On 9/27/21, Vault implementation engineers were made aware of a Synchrony permissions group called `LDAP sudo`.

This LDAP group allows members to execute Linux commands with the `sudo` suffix for a momentary elevation of system privileges. Membership to this group will allow for access to the Linux utility `systemctl` (as specified by steps `10,11` in the above installation steps).

It is not clear to HashiCorp engineers if `LDAP sudo` membership will afford attribute change privileges required for installation steps: `1, 2, 3`.

# HashiCorp Recommendations For 'Admin' & 'TBD' Install Steps

Below is a list of recommendations for installation steps requiring "Admin" access and steps listed as "METHOD TBD"

| Step  | Task | Unix command | Recommended Action |
| ------------- | ------------- | ------------- | ------------- |
| 1  | Create Vault Group  | `groupadd vault`  | If it is not possible to perform this step with `LDAP sudo` privileges, this step may performed prior to VM provisioning. If this group creation is performed during the VM image building phase, it would serve as an effective alternative to performing this action using Ansible.  |
| 2  | Create Vault User  | `useradd vault`  | If this user creation is performed during the VM image building phase, it would serve as an effective alternative to performing this action using Ansible.  |
| 3  | Create Vault User  | `install -m 0750 -o vault -g vault -d $vault_directory`  | HashiCorp recommends that the Vault directories belong to Linux user `vault` and Linux group `vault`. If the Vault directory creation is performed during the VM image building phase, it would serve as an effective alternative to performing this action using Ansible.  |
| 4  | Copy Vault Binary  | METHOD TBD  | Planning discussions between HashiCorp & Synchrony on 9/27, revealed that mirroring HashiCorp's public artifact repository was possible (Per Synchrony eng 'CV'). HashiCorp recommends this mirroring take place. Once completed, a method to own the binary to Linux user `vault` and Linux group `vault` must be determined.  |
| 5  | Create Vault TLS Directory  | `install -m 0750 -o vault -g vault -d $vault_directory`  | HashiCorp recommends that the Vault TLS directory belongs to Linux user `vault` and Linux group `vault`. If Vault directory creation is performed during the VM image building phase, it would serve as an effective alternative to performing this action using Ansible.  |
| 6  | Provision Vault TLS Files  | METHOD TBD  | As the TLS files are key to coordinating encrypted communication between Vault nodes, it is advised that TLS certificates be kept in an artifact repository such as "Artifactory." Synchrony will be required to determine a safe and effective method for retrieving these certificates from a given artifact repository.  |
| 7  | Provision Vault License File  | METHOD TBD  | HashiCorp Vault license renewal will require that the license file be replaced upon on expiration. HashiCorp recommends that this license file be kept and retrieved from an artifact repository, such as "Artfactory."  |
