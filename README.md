# Virtualmin Notes
## Grade A Supported Systems
- Rocky, Alma, and RHEL 8 and 9 on x86_64\
- CentOS and RHEL 7 on x86_64 (This version is extremely old and no longer recommended, please choose one of the above compatible systems instead.)\
- Ubuntu 20.04 LTS and 22.04 LTS on i386 and amd64\
- Debian 10, 11 and 12 on i386 and amd64



# Common Scripts
## System update & upgrade
Remarks: cannot install bcrypt
```shell
sudo apt -y update
sudo apt -y upgrade
sudo apt install -y screen vim tree net-tools wget curl tree unzip
```

## Install Rust
```shell
sudo apt install -y build-essential

sudo su -
export RUSTUP_HOME=/usr/local/lib/rustup
export CARGO_HOME=/usr/local/cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain stable
exit

sudo tee /etc/profile.d/rust.sh > /dev/null <<'EOF'
export CARGO_HOME=/usr/local/cargo
export RUSTUP_HOME=/usr/local/lib/rustup
export PATH="$CARGO_HOME/bin:$PATH"
EOF

sudo chmod +x /etc/profile.d/rust.sh

rustc --version
cargo --version
```

## Install Java
```shell
sudo apt install -y default-jdk
java -version
```

## Install PostgreSQL
```shell
sudo apt install -y postgresql
pg_config --version
```

## Install Node and npm
Reference: https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04
```shell
sudo apt install -y nodejs npm
node -v
npm -v
```

## Install Composer
```shell
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer
```

## Install Python
Reference: https://go.lightnode.com/tech/install-pip-ubuntu?ref=b7022283&id=58&gad_source=1&gad_campaignid=21352691918&gbraid=0AAAAABPLrSmCieTLf08S-nXt-6NxjBL3n&gclid=CjwKCAjw87XBBhBIEiwAxP3_AyNmOsxjc6L4QLVko2WyVSJSLiHaQ3ple43WQYNXMYIyOX6bpSAwQBoCC98QAvD_BwE

```shell
sudo apt install -y python3 python3-pip
python3 --version
pip3 --version
```

## Virtualmin
```shell
screen
wget https://software.virtualmin.com/gpl/scripts/virtualmin-install.sh
chmod 777 virtualmin-install.sh
sudo ./virtualmin-install.sh
```

## Install AWS CLI
Reference: https://forum.virtualmin.com/t/ubuntu-24-04-does-not-have-awscli/130361/2
```shell
snap install aws-cli --classic
```

## Install PHP (don't manually install this if Virtualmin will be used)
```shell
sudo apt-get install -y php-intl php-zip php-imagick php-cli
php -version
```

## Config second drive
```shell
//List all drive
lsblk

//partition, Use n to create a new partition, then w to write and exit.
sudo fdisk /dev/nvme0n1 (given that nvme0n1 is the second drive)

//Format the partition
sudo mkfs.ext4 /dev/nvme0n1p1

//Mount Temporarily for Data Move
sudo mkdir /mnt/newhome
sudo mount /dev/nvme0n1p1 /mnt/newhome
sudo rsync -aXS --exclude='/*/.gvfs' /home/. /mnt/newhome/.

//Unmount /mnt/newhome
sudo umount /mnt/newhome

//Get UUID of the Partition
sudo blkid /dev/nvme0n1p1

//Edit fstab
sudo vim /etc/fstab
```


Missing Steps
Firewall port redirect
SSH enable password





## Enable Quotas
Reference: https://www.digitalocean.com/community/tutorials/how-to-set-filesystem-quotas-on-ubuntu-20-04
```shell
screen
sudo apt update
sudo apt install quota
quota --version
find /lib/modules/ -type f -name '*quota_v*.ko*'
sudo apt install -y linux-image-extra-virtual linux-modules-extra-aws
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
Reference: https://docs.bitnami.com/virtual-machine/faq/get-started/enable-ssh-password/ \
Edit the /etc/ssh/sshd_config and modify or add the following line:
```shell
PasswordAuthentication yes
```
Restart the SSH server for the new configuration to take effect:
```shell
sudo /etc/init.d/ssh force-reload
sudo /etc/init.d/ssh restart
```

## Configure Password-Based SSH Authentication
Reference: https://superuser.com/questions/1032251/multiple-ssh-connections-to-the-same-system-is-it-possible \
MaxSessions Specifies the maximum number of open sessions permitted per network connection. The default is 10.
```shell
MaxSessions in /etc/ssh/sshd_config
```
Specifies the maximum number of concurrent unauthenticated connections to the SSH daemon... The default is 10.
```shell
#MaxStartups 10:30:60 usually commented in the /etc/ssh/sshd_config and by default set to 10
```

