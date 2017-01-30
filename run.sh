#!/bin/sh

set -e

: ${OPENLDAP_ALPINE_LISTEN_URI:="ldap:// ldaps://"}
: ${OPENLDAP_ALPINE_LOGLEVEL:="256"}


[ -z "$OPENLDAP_ALPINE_SKIP_CHOWN" ] && \
  chown -R ldap:ldap \
    /etc/openldap/slapd.d/ \
    /var/openldap/

/usr/sbin/slapd \
  -u ldap -g ldap \
  -h "$OPENLDAP_ALPINE_LISTEN_URI" \
  -d "$OPENLDAP_ALPINE_LOGLEVEL" \
  -F /etc/openldap/slapd.d/
