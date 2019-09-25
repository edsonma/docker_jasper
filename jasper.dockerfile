# Jasperserver Application Setup
#
# Created by: Edson Lek Hong Ma - edsonma@gmail.com
#
#   Whats New:
#   - First Version: 18/04/2019
#   Find base machine with on Java7
#   Instalation of Jasperserver 3.7.1-ce
#
#   - Sicorp Setup: 11/06/2019
#   Added sicorp-jasper project
#   Setup sicorp-jasper for jasperserver
#
#   - Todo List
#     Create options to any mysql database
#     Create options for other versions of app server
#     Optimize this dockerfile
##

FROM dockerbase/java7

RUN apt-get update && \
    apt-get install -y mysql-client git openssh-client keychain curl maven

RUN cd /opt && mkdir install
COPY install/* /opt/install/

RUN cd /opt && mkdir scripts
COPY scripts/install-jasper.sh /opt/scripts/
COPY scripts/jasper-entrypoint.sh /entrypoint.sh

RUN cd /opt && mkdir sicorp
RUN cd /opt/jasper && git clone git@github.com:edsonma/docker_jasper.git

RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -L https://get.rvm.io | bash -s stable 

RUN /bin/bash -l -c "source /etc/profile.d/rvm.sh && rvm requirements && rvm install 2.6.3 && gem install rake"

RUN cd /opt/jasper && /bin/bash -l -c "rake jasper:compile && rake jasper:package && rake jasper:install"

COPY scripts/copyLibs.sh /opt/scripts/
RUN bash -c -l "/opt/scripts/copyLibs.sh"

COPY libs/* /opt/install/apache-tomcat-6.0.53/lib/
COPY xml/applicationContext-logging.xml /opt/install/apache-tomcat-6.0.53/webapps/jasperserver/WEB-INF/
COPY xml/web.xml /opt/install/apache-tomcat-6.0.53/webapps/jasperserver/WEB-INF/

COPY xml/context.xml /opt/install/apache-tomcat-6.0.53/conf/

WORKDIR /opt/install

RUN tar -zxvf apache-tomcat-6.0.53.tar.gz && rm apache-tomcat-6.0.53.tar.gz
RUN tar -zxvf jasperserver-ce-3.7.1.tar.gz && rm jasperserver-ce-3.7.1.tar.gz

COPY scripts/default_master.properties /opt/install/jasperserver-ce-3.7.1-bin/buildomatic/

EXPOSE 8080

WORKDIR /opt/scripts

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/opt/install/apache-tomcat-6.0.53/bin/./catalina.sh", "run"]


