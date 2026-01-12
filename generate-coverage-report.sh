#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JACOCO_CLI="${SCRIPT_DIR}/jacoco_agent/org.jacoco.cli-0.8.7-nodeps.jar"
EXEC_FILE="${SCRIPT_DIR}/jacoco_coverage/jacoco.exec"
CLASSES_DIR="${SCRIPT_DIR}/WebContent/WEB-INF/classes"
SOURCE_DIR="${SCRIPT_DIR}/src"
REPORT_DIR="${SCRIPT_DIR}/jacoco_coverage/report"

# Without this the class names are wrong and coverage shows 0%
if docker ps --filter "name=banking-app" --format "{{.Names}}" | grep -q "banking-app"; then
    echo "Extracting class files from running container..."
    docker cp banking-app:/usr/local/tomcat/webapps/ROOT/WEB-INF/classes/. "$CLASSES_DIR"
    echo ""
fi

if [ ! -f "$EXEC_FILE" ]; then
    echo "ERROR: Coverage data file not found at: $EXEC_FILE"
    exit 1
fi

if [ ! -d "$CLASSES_DIR" ]; then
    echo "compile the application first."
    exit 1
fi

mkdir -p "$REPORT_DIR"

java -jar "$JACOCO_CLI" report "$EXEC_FILE" \
    --classfiles "$CLASSES_DIR" \
    --sourcefiles "$SOURCE_DIR" \
    --html "$REPORT_DIR" \
    --name "Online Banking System Coverage"

open ${REPORT_DIR}/index.html
