#!/bin/bash

set -e

: ${OPENLDAP_ALPINE_CNCONFIG_PW:?"missing variable OPENLDAP_ALPINE_CNCONFIG_PW"}
CNCONFIG_PW_HASH="$(/usr/sbin/slappasswd -h '{SSHA}' -s $OPENLDAP_ALPINE_CNCONFIG_PW)"

cat << EOF > /tmp/config.ldif
dn: cn=config
objectClass: olcGlobal
cn: config

dn: olcDatabase={0}config,cn=config
objectClass: olcDatabaseConfig
olcDatabase: config
olcRootDN: cn=config
olcRootPW: $CNCONFIG_PW_HASH

EOF

rm -rf /etc/openldap/slapd.d/*
/usr/sbin/slapadd -n0 -F "/etc/openldap/slapd.d" -l /tmp/config.ldif
chown -R ldap:ldap /etc/openldap/slapd.d/

rm /tmp/config.ldif


