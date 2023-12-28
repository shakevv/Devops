# Modern Devops Practices Course Project

The project is CI pipeline which creates Docker image of Python application and pushes it to Dockerhub. The pipeline is triggered on push to a branch which is different from the main branch, on opened Pull Request and on Merged Pull Request to the main branch. Depending on the github event different jobs are executed. The jobs are: 
 - secrets-check (runs every time)
 - code-style-check (runs every time)
 - unit-testing (runs every time)
 - sca-sast-scan-and-reporting (runs every time)
 - database-migrations-test (runs every time)
 - docker-img-test-and-report (runs every time)
 - docker-build-and-push-img (runs on merged PR to the main branch)

 ## Performed tasks during the pipeline execution:

 ### General Pipeline Info:
- Create a GitHub Actions workflow that builds a Docker image for our application
- Run jobs in parallel
- Implement job dependency
- Implement a new Github workflow at Merged Pull Request
- Have Dockerfile for optimized Docker image size

### Style (code-style-check job)
- Check code style & lint with `flake8`
- Check .editorconfig with `editorconfig-checker`
- Check makrdown files using `markdownlint-cli`

### Security testing (secrets-check, unit-testing, sca-sast-scan-and-reporting)
- Run unit tests
- Make Software Composition Analysis (SCA) scan on the application code with `Snyk`
- Make Static Application Security Testing (SAST) scan on the application code with `Snyk`
- Upload reports to Github for problems found during the SCA and SAST scans
- Stop the pipeline if any problems are found but the reports contain full information for the vulnerabilities
- Check for hardcoded secrets with `gitleaks` and stop the pipeline if any hardcoded secret is found

### Database migrations
- Check for database migrations using `flyway`

### Containerization
- Containerize the Python application in the src/ directory. We have a Dockerfile and use ubuntu as a base image
- Scan the built Docker image with `Trivy`
- Upload scan report to Github
- Stop pipeline if high severity problems are found
- Create test container from the image
- Publish the image DockerHub