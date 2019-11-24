#!/bin/bash

echo "Installing Python 3.7"
yum install gcc openssl-devel bzip2-devel libffi-devel wget
cd /usr/src
wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
tar xzf Python-3.7.4.tgz
cd Python-3.7.4
./configure --enable-optimizations
make install
ln -sf /usr/local/bin/python3.7 /usr/bin/python

echo "Install python pip"
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
/usr/local/bin/python get-pip.py

echo "install prerequisite module"
pip install --user --requirement requirements.txt
pip install requests --upgrade
