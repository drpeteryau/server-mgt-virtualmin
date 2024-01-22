Grade A Supported Systems
Rocky, Alma, and RHEL 8 and 9 on x86_64
CentOS and RHEL 7 on x86_64 (This version is extremely old and no longer recommended, please choose one of the above compatible systems instead.)
Ubuntu 20.04 LTS and 22.04 LTS on i386 and amd64
Debian 10, 11 and 12 on i386 and amd64

virtualmin: 
wget https://software.virtualmin.com/gpl/scripts/virtualmin-install.sh
chmod 777 virtualmin-install.sh
sudo ./virtualmin-install.sh

setup Quotas
reference: https://www.digitalocean.com/community/tutorials/how-to-set-filesystem-quotas-on-ubuntu-20-04

sudo apt update
sudo apt install quota
quota --version
find /lib/modules/ -type f -name '*quota_v*.ko*'
sudo apt install linux-image-extra-virtual
sudo vim /etc/fstab
usrquota,grpquota
sudo mount -o remount /
sudo quotacheck -ugm /

update
sudo apt-get install php-intl php-zip 
sudo apt-get install screen vim tree net-tools

migrate: https://www.virtualmin.com/documentation/system/migrate/
du -h --threshold=1G | sort -h
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
