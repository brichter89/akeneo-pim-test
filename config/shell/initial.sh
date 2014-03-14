#!/bin/sh

echo -- Installing sources.list
cp "/vagrant/config/files/etc/apt/sources.list" "/etc/apt/sources.list" >/dev/null || exit $?
chown root:root "/etc/apt/sources.list" >/dev/null || exit $?

echo -- Updateing apt sources
apt-get -y -qq update >/dev/null || exit $?

echo -- Installing python-software-properties
apt-get -y -qq install python-software-properties >/dev/null || exit $?

echo -- Adding ppa for php5
apt-add-repository -y ppa:ondrej/php5 >/dev/null 2>/dev/null || exit $?

echo -- Updateing apt sources again
apt-get -y -qq update >/dev/null || exit $?

echo -- Installing common packages
apt-get -y -qq install build-essential vim vim-common bash-completion unzip >/dev/null || exit $?

echo -- Setting default editor to vim basic
update-alternatives --quiet --set editor /usr/bin/vim.basic >/dev/null || exit $?
