#!/bin/bash


# Temporary dump staging folder
  TMP=$(mktemp -d -t tmp.XXXXXXXXXX)
#
# @method to delete Temporary folder
#
function finish {
  rm -rf "$TMP"
}
trap finish EXIT


zmprov -l gaa -v | grep -e uid: -e zimbraCOSId | grep -B1  1ed371c3-b8b6-43ea-af9f-4bd569f7a472 | grep uid: | awk '{print $2}' > "$TMP/jusa.txt"

account=`cat "$TMP/jusa.txt"`

for account in ${account}
do
mb_size=`zmmailbox -z -m ${account}@mpob.gov.my gms`
echo Mailbox size of ${account}@mpob.gov.my = ${mb_size}.;
done
