# Development Commands

## Static Analysis (Semgrep)

`semgrep --config=auto .`

## Code Coverage (JaCoCo)

`./generate-coverage-report.sh`

## Dynamic Analysis (OWASP ZAP)

`docker run -u zap -p 8090:8080 -p 8091:8443 -d --name zap ghcr.io/zaproxy/zaproxy:stable zap-webswing.sh`

## Dependency Check (OWASP)

`docker run --rm -v "$(pwd)":/src owasp/dependency-check:latest --scan /src/lib --format HTML --project "OnlineBankingSystem" --out /src/dependency-check-report`
