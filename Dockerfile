FROM alpine:3.5
MAINTAINER dariko <git@dariozanzico.com>

ENV OPENLDAP_ALPINE_VERSION 2.4.44-r3
RUN apk --no-cache --update --update --no-cache add \
    openldap=$OPENLDAP_ALPINE_VERSION \
    openldap-clients=$OPENLDAP_ALPINE_VERSION

EXPOSE 389
EXPOSE 636
