FROM openjdk
FROM ubuntu 
FROM tomcat
COPY **/*.war /usr/local/tomcat/webapps
WORKDIR  /usr/local/tomcat/webapps
RUN apt update -y && apt install curl -y
RUN curl -O https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip && \
    apt-get install unzip -y  && \
    unzip newrelic-java.zip -d  /usr/local/tomcat/webapps
ENV JAVA_OPTS="$JAVA_OPTS -javaagent:app/newrelic.jar"
ENV NEW_RELIC_APP_NAME="Petadoption"
ENV NEW_RELIC_LOG_FILE_NAME=STDOUT
ENV NEW_RELIC_LICENCE_KEY="eu01xx87e2156505f6e2e6859d18e604ad38NRAL"
ADD ./newrelic.yml /usr/local/tomcat/webapps/newrelic/newrelic.yml
WORKDIR  /usr/local/tomcat/webapps
RUN pwd && ls -al
ENTRYPOINT ["java", "-javaagent:/usr/local/tomcat/webapps/newrelic/newrelic.jar", "-jar", "spring-petclinic-2.4.2.war", "--server.port=8085"]
