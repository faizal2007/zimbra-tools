#!/bin/bash
FOOTER="`zmprov gcf zimbraDomainMandatoryMailSignatureEnabled | awk -F ":" '{print $2}'`"
TLD="`zmprov gs \`zmhostname\` | grep "zimbraServiceHostname:" | awk -F: '{ print $NF }' | cut -d"." -f2,3,4`"

##
# Enable global footer

if [ $FOOTER != "TRUE" ]; then
    zmprov mcf zimbraDomainMandatoryMailSignatureEnabled TRUE
fi

##
# Generating footer

cd ~
zmprov md $TLD zimbraAmavisDomainDisclaimerHTML "`cat footer/html`"
./libexec/zmaltermimeconfig -e $TLD
./libexec/zmaltermimeconfig
