# Stage 1: Build
FROM maven:3.8-eclipse-temurin-8 AS builder

WORKDIR /app

COPY src/ /app/src/
COPY WebContent/ /app/WebContent/
COPY lib/ /app/lib/

RUN mkdir -p /app/WebContent/WEB-INF/classes

RUN apt-get update && apt-get install -y wget && \
    wget https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar -O /tmp/servlet-api.jar

RUN javac -cp "/app/lib/*:/tmp/servlet-api.jar" \
    -d /app/WebContent/WEB-INF/classes \
    $(find /app/src -name "*.java")

# Stage 2: Deploy
FROM tomcat:8.5-jdk8-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/WebContent/ /usr/local/tomcat/webapps/ROOT/
COPY lib/mysql-connector-java-8.0.22.jar /usr/local/tomcat/lib/
COPY jacoco_agent/org.jacoco.agent-0.8.7-runtime.jar /opt/jacoco/jacocoagent.jar

RUN mkdir -p /jacoco_output && chmod 777 /jacoco_output

EXPOSE 8080

ENV JAVA_OPTS="-javaagent:/opt/jacoco/jacocoagent.jar=destfile=/jacoco_output/jacoco.exec,classdumpdir=/jacoco_output/classes"
CMD ["catalina.sh", "run"]
