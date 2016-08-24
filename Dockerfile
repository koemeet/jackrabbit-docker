FROM tomcat:8-jre7

RUN wget -O /opt/jcr-2.0.zip http://download.oracle.com/otn-pub/jcp/content_repository-2.0-fr-oth-JSpec/content_repository-2_0-final-spec.zip \
    && cd /opt && unzip /opt/jcr-2.0.zip && rm -rf /opt/jcr-2.0.zip

# download mysql connector
RUN wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.39.tar.gz \
    -O /opt/mysql-connector.tar.gz \
    && tar -zxvf /opt/mysql-connector.tar.gz -C /opt

# copy jar to tomcat lib
RUN mv /opt/jsr-283-fcs/lib/jcr-2.0.jar /usr/local/tomcat/lib/ \
    && mv /opt/mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar /usr/local/tomcat/lib/

RUN rm -rf /usr/local/tomcat/webapps/*

RUN wget -O /usr/local/tomcat/webapps/ROOT.war http://apache.hippo.nl/jackrabbit/2.13.1/jackrabbit-webapp-2.13.1.war

RUN echo "Deploying war file, so we can make some changes to it later..." \
    && catalina.sh start && sleep 12 && catalina.sh stop \
    && rm -rf /usr/local/tomcat/webapps/ROOT.war

RUN ls -la /usr/local/tomcat/webapps

RUN sed -i 's/jackrabbit\/bootstrap\.properties/\/opt\/jackrabbit\/bootstrap\.properties/g' /usr/local/tomcat/webapps/ROOT/WEB-INF/web.xml

COPY ./bootstrap.properties /opt/jackrabbit/
COPY ./repository.xml /opt/jackrabbit/repository.xml

WORKDIR /opt/jackrabbit