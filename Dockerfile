# Multi-stage build for Java Banking Application

# Stage 1: Build the application
FROM maven:3.8-eclipse-temurin-8 AS builder

WORKDIR /app

# Copy source code and libraries
COPY src/ /app/src/
COPY WebContent/ /app/WebContent/
COPY lib/ /app/lib/

# Create build directory
RUN mkdir -p /app/WebContent/WEB-INF/classes

# Install servlet-api for compilation
RUN apt-get update && apt-get install -y wget && \
    wget https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar -O /tmp/servlet-api.jar

# Compile Java source files
RUN javac -cp "/app/lib/*:/tmp/servlet-api.jar" \
    -d /app/WebContent/WEB-INF/classes \
    $(find /app/src -name "*.java")

# Stage 2: Deploy to Tomcat
FROM tomcat:8.5-jdk8-temurin

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the application
COPY --from=builder /app/WebContent/ /usr/local/tomcat/webapps/ROOT/

# Copy MySQL JDBC driver to Tomcat lib
COPY lib/mysql-connector-java-8.0.22.jar /usr/local/tomcat/lib/

# Copy JaCoCo agent
COPY jacoco_agent/org.jacoco.agent-0.8.7-runtime.jar /opt/jacoco/jacocoagent.jar

# Create directory for coverage output
RUN mkdir -p /jacoco_output && chmod 777 /jacoco_output

# Expose port
EXPOSE 8080

# Configure JaCoCo agent in CATALINA_OPTS and start Tomcat
ENV JAVA_OPTS="-javaagent:/opt/jacoco/jacocoagent.jar=destfile=/jacoco_output/jacoco.exec,classdumpdir=/jacoco_output/classes"
CMD ["catalina.sh", "run"]
