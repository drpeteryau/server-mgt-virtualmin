# Virtualmin Notes
## Grade A Supported Systems
- Rocky, Alma, and RHEL 8 and 9 on x86_64\
- CentOS and RHEL 7 on x86_64 (This version is extremely old and no longer recommended, please choose one of the above compatible systems instead.)\
- Ubuntu 20.04 LTS and 22.04 LTS on i386 and amd64\
- Debian 10, 11 and 12 on i386 and amd64



# Common Scripts
## System update & upgrade
```shell
sudo apt -y update
sudo apt -y upgrade
sudo apt install -y screen vim tree net-tools wget curl tree
Remarks: cannot install bcrypt
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

## Virtualmin
```shell
screen
wget https://software.virtualmin.com/gpl/scripts/virtualmin-install.sh
chmod 777 virtualmin-install.sh
sudo ./virtualmin-install.sh
```

## Install PHP (don't manually install this if Virtualmin will be used)
```shell
sudo apt-get install -y php-intl php-zip php-imagick
php -version
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

