# Virtualmin Notes
## Grade A Supported Systems
Rocky, Alma, and RHEL 8 and 9 on x86_64\
CentOS and RHEL 7 on x86_64 (This version is extremely old and no longer recommended, please choose one of the above compatible systems instead.)\
Ubuntu 20.04 LTS and 22.04 LTS on i386 and amd64\
Debian 10, 11 and 12 on i386 and amd64

# Common Scripts
## System update & upgrade
```shell
sudo apt update
sudo apt upgrade
sudo apt-get install -y screen vim tree net-tools wget
sudo apt-get install -y bcrypt
```

## Install PHP
```shell
sudo apt-get install php-intl php-zip
```

## Install Java
```shell
sudo apt install default-jdk
```

## Virtualmin
```shell
screen
wget https://software.virtualmin.com/gpl/scripts/virtualmin-install.sh
chmod 777 virtualmin-install.sh
sudo ./virtualmin-install.sh
```

## Enable Quotas
Reference: https://www.digitalocean.com/community/tutorials/how-to-set-filesystem-quotas-on-ubuntu-20-04
```shell
screen
sudo apt update
sudo apt install quota
quota --version
find /lib/modules/ -type f -name '*quota_v*.ko*'
sudo apt install linux-image-extra-virtual linux-modules-extra-aws
sudo vim /etc/fstab
#usrquota,grpquota
sudo mount -o remount /
sudo quotacheck -ugm /
```

## Migrate
Reference: https://www.virtualmin.com/documentation/system/migrate/
```shell
du -h --threshold=1G | sort -h
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```


# Common Configurations
## Configure Password-Based SSH Authentication
Reference: https://docs.bitnami.com/virtual-machine/faq/get-started/enable-ssh-password/\
Edit the /etc/ssh/sshd_config and modify or add the following line:
```shell
PasswordAuthentication yes
```
Restart the SSH server for the new configuration to take effect:
```shell
sudo /etc/init.d/ssh force-reload
sudo /etc/init.d/ssh restart

```
