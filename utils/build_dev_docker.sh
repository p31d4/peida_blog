#!/bin/bash

# docker build --tag <name:tag> - < Dockerfile
docker buildx build --file Dockerfile_Dioxus_DevEnv --tag p31d4/dx_devenv:0.1 .
