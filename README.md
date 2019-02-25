# Introduction
This is a Dockerfile for building a container image containing Ansible kernel, Jupyter, and JupyterThemes. You should have a container platform and docker installed.

# Installation Instructions
## Getting from DockerHub
The easiest way to install is from dockerhub: `docker pull stoleas/docker-jupyter-ansible:latest`

To run the image you can use the following command: `docker run  --restart always -d --expose 8888 -p 8888:8888 stoleas/docker-jupyter-ansible:latest`

[View image on DockerHub](https://cloud.docker.com/u/stoleas/repository/docker/stoleas/docker-jupyter-ansible)

## Manual Installation
### Build
To build this image you can run the following commands

```bash
git clone https://github.com/stoleas/docker-jupyter-ansible
cd docker-jupyter-ansible
docker built -t docker-jupyter-ansible .
```
### Run
When the build is complete you can run this image by getting the docker image id. The command for listing docker images is `docker images`.

```bash
docker run  --restart always -d --expose 8888 -p 8888:8888 ${IMAGE_ID}
```

## Getting the Jupyter URL hash
To list all running containers you can run `docker ps -a` and get the container ID and run `docker logs ${CONTAINER_ID}`.