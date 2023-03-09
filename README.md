# Website

[![CI](https://github.com/nseguin42/ns_umbrella/actions/workflows/ci.yaml/badge.svg?branch=main&event=push)](https://github.com/nseguin42/ns_umbrella/actions/workflows/ci.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An Elixir umbrella project for my personal website. See it live: [nsegu.in](http://nsegu.in).

## About

### CI/CD Pipeline

Each pull request triggers a [CI workflow](./.github/workflows/ci.yaml) that lints, builds, and
tests the project. The test environment is configured in `.env.test`, and the database is provided
by a Docker container (see [docker-compose.yml](./docker-compose.yml)).

The CI workflow is also triggered when a commit is pushed to the `main` branch. In this case, the
Docker image is tagged with the commit SHA and deployed to [DockerHub](https://hub.docker.com/repository/docker/nseguin42/website).
