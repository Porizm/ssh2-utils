#!/usr/bin/env bash

# from https://github.com/benoitbryon/xal/blob/master/.travis-ssh.sh


# Allow ``ssh localhost`` with empty passphrase on travis-ci.org continuous
# integration platform.

# Make sure we are on Travis.
if [ ! $TRAVIS ]; then
    echo "This script is made for travis-ci.org! It cannot run without \$TRAVIS."
    exit 1
fi

# Run SSH service, configure automatic access to localhost.
sudo start ssh
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N "" -q
cat ~/.ssh/id_rsa.pub >>~/.ssh/authorized_keys
ssh-keyscan -t rsa localhost >>~/.ssh/known_hosts
cat << EOF >> ~/.ssh/config
Host localhost
     IdentityFile ~/.ssh/id_rsa
EOF

sudo useradd --home /home/tpwd/ --gid travis --groups travis --password 123456tpwd tpwd

sudo cat /etc/passwd
sudo cat /etc/sshd/sshd_config
