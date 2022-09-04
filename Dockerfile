FROM centos:7
LABEL maintainer="kartikeyait@gmail.com"
ARG USERNAME=tomuser
ARG TOM_HOME=/opt/apache-tomcat-9.0.65
ARG WAR=https://raw.githubusercontent.com/kartikeyapro/test/master/ksdemo.war
ARG GROUP=tomuser
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $USERNAME
RUN useradd -u $UID -g $GID -o -s /bin/bash $USERNAME
RUN yum update -y && yum install wget -y && yum install java-1.8.0-openjdk -y;
ADD apache-tomcat-9.0.65.tar.gz /opt/
RUN rm -rf /opt/apache-tomcat-9.0.65/webapps/
ADD $WAR /opt/apache-tomcat-9.0.65/webapps/  
RUN chown $USERNAME:$USERNAME ${TOM_HOME}
EXPOSE 8080


