# ================================
# Stage 1: Build + SpotBugs report
# ================================
FROM maven:3.8-eclipse-temurin-8 AS builder

WORKDIR /app

# Copy sources and resources
COPY src/ /app/src/
COPY WebContent/ /app/WebContent/
COPY lib/ /app/lib/

# Prepare output directory
RUN mkdir -p /app/WebContent/WEB-INF/classes

# Install tools + servlet API
RUN apt-get update && apt-get install -y wget && \
    wget https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar \
    -O /tmp/servlet-api.jar

# Compile Java sources
RUN javac \
    -cp "/app/lib/*:/tmp/servlet-api.jar" \
    -d /app/WebContent/WEB-INF/classes \
    $(find /app/src -name "*.java") && \
    echo "Compilation complete. Classes:" && \
    find /app/WebContent/WEB-INF/classes -type f -name "*.class" | head -10

# Download SpotBugs and FindSecBugs
RUN wget https://repo1.maven.org/maven2/com/github/spotbugs/spotbugs/4.8.3/spotbugs-4.8.3.tgz && \
    tar xzf spotbugs-4.8.3.tgz && \
    wget https://repo1.maven.org/maven2/com/h3xstream/findsecbugs/findsecbugs-plugin/1.13.0/findsecbugs-plugin-1.13.0.jar \
    -O /app/spotbugs-4.8.3/lib/findsecbugs-plugin-1.13.0.jar && \
    chmod +x /app/spotbugs-4.8.3/bin/spotbugs && \
    ls -lh /app/spotbugs-4.8.3/lib/findsecbugs* && \
    echo "SpotBugs and FindSecBugs downloaded"

# Create reports directory and run analysis WITH FindSecBugs explicitly enabled
RUN mkdir -p /app/reports && \
    echo "Starting SpotBugs + FindSecBugs HTML analysis..." && \
    /app/spotbugs-4.8.3/bin/spotbugs \
    -html \
    -effort:max \
    -low \
    -pluginList /app/spotbugs-4.8.3/lib/findsecbugs-plugin-1.13.0.jar \
    -auxclasspath "/app/lib/*:/tmp/servlet-api.jar" \
    -output /app/reports/spotbugs.html \
    /app/WebContent/WEB-INF/classes && \
    echo "HTML report created" && \
    ls -lh /app/reports/

# Generate XML report for CI/CD integration WITH FindSecBugs
RUN echo "Starting SpotBugs + FindSecBugs XML analysis..." && \
    /app/spotbugs-4.8.3/bin/spotbugs \
    -xml \
    -effort:max \
    -low \
    -pluginList /app/spotbugs-4.8.3/lib/findsecbugs-plugin-1.13.0.jar \
    -auxclasspath "/app/lib/*:/tmp/servlet-api.jar" \
    -output /app/reports/spotbugs.xml \
    /app/WebContent/WEB-INF/classes && \
    echo "XML report created" && \
    ls -lh /app/reports/


# ================================
# Stage 2: Tomcat runtime
# ================================
FROM tomcat:8.5-jdk8-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy application
COPY --from=builder /app/WebContent/ /usr/local/tomcat/webapps/ROOT/

# Copy SpotBugs reports
COPY --from=builder /app/reports/ /usr/local/tomcat/webapps/ROOT/reports/

# MySQL driver
COPY lib/mysql-connector-java-8.0.22.jar /usr/local/tomcat/lib/

EXPOSE 8080

CMD ["catalina.sh", "run"]
