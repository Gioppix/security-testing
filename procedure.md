# What I've done

- Ran semgrep
- Went through the various issues
- found some related to login
- inspected the code
- tried multiple approaches in the web page
- managed to both login as a random user or through a known username

- Tried running JaCoCO but the code has no tests, so it's pointless
- However, I can still see runtime code coverage.
- Managed to do it but I have to manually visit every page.
- now trying a fuzz tester (zap)

- Ran owasp/dependency-check:
- ```bash
  docker run --rm \
    -v "$(pwd)":/src \
    owasp/dependency-check:latest \
    --scan /src/lib \
    --format HTML \
    --format JSON \
    --project "OnlineBankingSystem" \
    --out /src/dependency-check-report
  ```
-

- Even tho there is no "public" page for content, SQL injections should still let us update other user's account
- just appending update statements is not enough
- mysql does not support a select ... union all update ... returning
- stacked queries attacks not working on login page; now trying LoadServlet as it has a prepareStatement where parameters are inserted immediately
