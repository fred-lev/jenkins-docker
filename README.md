# Jenkins Docker

Dockerfiles to run Jenkins as well as a Docker In Docker container used to run the docker agents.

## REM

The docker client on the Jenkins side is using shared certs to connect to the docker server running in the DIND container.

## Note

For testing purposes I am running this on a t2.large in AWS.
