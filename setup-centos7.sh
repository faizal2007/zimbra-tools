#!/bin/bash

REQUIREMENT="$(pwd)/requirements.txt"

echo "Installing Python 3.7"
yum install gcc openssl-devel bzip2-devel libffi-devel wget 
cd /usr/src
wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
tar xzf Python-3.7.4.tgz
cd Python-3.7.4
./configure --enable-optimizations
make install
rm -rvf /usr/src/Python-3.7.4.tgz

#ln -sf /usr/local/bin/python3.7 /usr/bin/python
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

echo "Install python pip"
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
/usr/local/bin/python3.7 get-pip.py

echo "install prerequisite module"
/usr/local/bin/pip install --user --requirement $REQUIREMENT
/usr/local/bin/pip install requests --upgrade
