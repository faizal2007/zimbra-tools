#!/bin/bash

yum install centos-release-scl
yum install rh-python36
scl enable rh-python36 bash

echo "install prerequisite module"
pip install --upgrade pip
pip install --user --requirement requirements.txt
echo "install prerequisite module"
pip install --user --requirement requirements.txt
