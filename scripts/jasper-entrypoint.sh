#!/bin/bash
set -e


CATALINA_HOME=/opt/install/apache-tomcat-6.0.53

USER_ID=${TOMCAT_USER_ID:-1000}
GROUP_ID=${TOMCAT_GROUP_ID:-1000}

# Tomcat user
groupadd -r tomcat -g ${GROUP_ID} && \
useradd -u ${USER_ID} -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin \
    -c "Tomcat user" tomcat

# Change CATALINA_HOME ownership to tomcat user and tomcat group
chown -R tomcat:tomcat ${CATALINA_HOME} && chmod 400 ${CATALINA_HOME}/conf/*
sync

DBNAME="jasperserver"
DBEXISTS=$(mysql --host=jasperdb -u root --password="root" --batch --skip-column-names -e "SHOW DATABASES LIKE '"$DBNAME"';" | grep "$DBNAME" > /dev/null; echo "$?")
if [ $DBEXISTS -eq 0 ];then
    echo "A database with the name $DBNAME already exists."
else
    echo "$DBNAME does not exist and I'm going to set it up"
    cd /opt/install/jasperserver-ce-3.7.1-bin/buildomatic && /opt/scripts/./install-jasper.sh
fi

exec "$@"

