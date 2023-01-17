<div align="center">

# Laravel DevContainer

![GitHub](https://img.shields.io/github/license/laramatics/dev)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/laramatics/dev/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/laramatics/dev)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/laramatics/dev)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/laramatics/dev)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/laramatics/dev)

</div>

## About

This repository contains all features of [laramatics/container](https://github.com/laramatics/container)
and [laramatics/gitlab-ci](https://github.com/laramatics/app) to give you full features needed
to start developing your next awesome project.

## How to use

Simply run this command in your project directory:

```shell
docker run --name=myapp -d -p 8081:80 -v $(pwd):/var/www/html laramatics/dev
```

now you can access your app from [http://localhost:8081](http://localhost:8081).

if you want to install npm/composer packages simply ssh into your container and do what you need to do:

```shell
docker exec -it myapp ash
```

Enjoy.