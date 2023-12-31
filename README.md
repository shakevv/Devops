# Modern Devops Practices Course Project

## CI pipeline + deploy the image to local Kubernetes cluster

The project is a GitHub Actions workflow that builds a Docker image of Python application and pushes it to Dockerhub. The pipeline is triggered on push to a branch which is different from the main branch, on opened Pull Request and on Merged Pull Request to the main branch. Depending on the github event different jobs are executed. The jobs are: 
 - secrets-check 
 - code-style-check 
 - unit-testing 
 - sca-sast-scan-and-reporting 
 - database-migrations-test 
 - docker-img-test-and-report 
 - docker-build-and-push-img (runs only on merged PR to the main branch)

 ## Performed tasks:

 ### Pipeline
- Create a GitHub Actions workflow that builds a Docker image for our application
- Run jobs in parallel
- Implement job dependency
- Implement a different Github workflow at Merged Pull Request
- Have Dockerfile for optimized Docker image size

### Style (code-style-check job)
- Check code style & lint with `flake8`
- Check .editorconfig with `editorconfig-checker`

### Security testing (secrets-check, unit-testing, sca-sast-scan-and-reporting jobs)
- Run unit tests
- Make Software Composition Analysis (SCA) scan on the application code with `snyk`
- Make Static Application Security Testing (SAST) scan on the application code with `snyk`
- Upload reports to Github for problems found during the SCA and SAST scans
- Stop the pipeline if any problems are found
- Check for hardcoded secrets with `gitleaks` and stop the pipeline if any hardcoded secret is found

### Database migrations (database-migrations-test job)
- Check for database migrations using `flyway`

### Containerization (docker-img-test-and-report, docker-build-and-push-img jobs)
- Create test image for the Python application in the src/ directory. We have a Dockerfile and use ubuntu as a base image
- Scan the built Docker image with `trivy`
- Upload scan report to Github
- Stop pipeline if high severity problems are found
- Create test container from the image
- Create final image and publish it to DockerHub


## Deploy the image to local Kubernetes cluster

- `kubectl create deployment myapp --image=shakevv/devops:latest --replicas=2` creates a deployment with two pods created from our image 

- `kubectl expose deployment/myapp --type="NodePort" --port 5000` exposes the deployment outside the kubernetes cluster

- `kubectl get all` to find the port to which the deployment is exposed
