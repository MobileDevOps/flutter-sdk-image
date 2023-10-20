# Docker image for Flutter SDK

Docker image to build a Flutter app `*.apk` for Android. The latest image contains always the latest stable version of the Flutter SDK: https://flutter.dev/docs/development/tools/sdk/releases?tab=linux

Currently:

| Version  | Ref | Release Date |
|---|---|---|
| 3.13.8 | 6c4930c | 18.10.2023 |

## Releases

| Tag | Flutter Version | Flutter Channel |
|---|---|---|
| 3.10.3 | 3.10.3 | stable |
| 3.10.2 | 3.10.2 | stable |
| 3.10.1 | 3.10.1 | stable |
| 3.10.0 | 3.10.0 | stable |
| 3.7.12 | 3.7.12 | stable |
| 3.7.11 | 3.7.11 | stable |
| 3.7.10 | 3.7.10 | stable |
| 3.7.9 | 3.7.9 | stable |
| 3.7.8 | 3.7.8 | stable |
| 3.7.7 | 3.7.7 | stable |
| 2.0.1 | 2.0.1 | stable |
| 1.22.5 | 1.22.5 | stable |
| 1.22.4 | 1.22.4 | stable |
| 1.22.3 | 1.22.3 | stable |
| 1.22.2 | 1.22.2 | stable |
| 1.22.1 | 1.22.1 | stable |
| 1.22.0 | 1.22.0 | stable |
| 1.20.4 | 1.20.4 | stable |
| 1.20.3 | 1.20.3 | stable |
| 1.20.2 | 1.20.2 | stable |
| 1.20.1 | 1.20.1 | stable |
| 1.20.0 | 1.20.0 | stable |
| 1.17.5 | 1.17.5 | stable |
| 1.17.4 | 1.17.4 | stable |
| 1.17.3 | 1.17.3 | stable |
| 1.17.2 | 1.17.2 | stable |
| 1.17.1 | 1.17.1 | stable |
| 1.17.0 | 1.17.0 | stable |
| v1.12.13-hotfix.9 | v1.12.13+hotfix.9 | stable |
| v1.12.13-hotfix.8 | v1.12.13+hotfix.8 | stable |
| v1.12.13-hotfix.7 | v1.12.13+hotfix.7 | stable |
| v1.12.13-hotfix.5 | v1.12.13+hotfix.5 | stable |
| v1.9.1-hotfix.6 | v1.9.1+hotfix.6 | stable |
| v1.9.1-hotfix.5 | v1.9.1+hotfix.5 | stable |
| v1.9.1-hotfix.4 | v1.9.1+hotfix.4 | stable |
| v1.9.1-hotfix.2 | v1.9.1+hotfix.2 | stable |
| v1.7.8-hotfix.4 | v1.7.8+hotfix.4 | stable |

## Usage

The image can be used on different cloud build services or own hosted pipeline solutions like Travis CI, CircleCI or GitLab CI/CD.

### CircleCI

CircleCI supports the direct specification of a Docker image and checks out the source code in it: https://circleci.com/docs/2.0/circleci-images/

Therefore you execute your CI script directly in the container.

Example:

```
# .circleci/config.yml
version: 2.1
jobs:
  build:
    docker: 
      - image: mobiledevops/flutter-sdk-image:3.10.3
    steps:
      - checkout
      - run:
          name: Flutter Build
          command: flutter build apk
```

Example Project: https://github.com/mobiledevops/flutter-ci-demo

### Travis CI 

To use a Docker container on Travis CI, you have to pull, run and execute it manually because Travis CI has no Docker executor: https://docs.travis-ci.com/user/docker/

And to prevent to do a new checkout of the source code in the Docker image, you can copy the code into the container via `tar` (see https://docs.docker.com/engine/reference/commandline/cp/).
To execute your CI script, use `docker exec` with the container name.

Example:

```
# .travis.yml
dist: bionic

services:
  - docker

env:
  - DOCKER_IMAGE=mobiledevops/flutter-sdk-image:3.10.3

before_install:
  - docker pull $DOCKER_IMAGE
  - docker run --name android_ci -t -d $DOCKER_IMAGE /bin/sh
  - tar Ccf . - . | docker exec -i android_ci tar Cxf /home/mobiledevops/app -

script:
  - docker exec android_ci flutter build apk
```
Example Project: https://github.com/mobiledevops/flutter-ci-demo

### GitLab CI

GitLab CI/CD supports to run jobs on provided Docker images: https://docs.gitlab.com/runner/executors/docker.html

Therefore you execute your CI script directly in the container.

Example:

```
# .gitlab-ci.yml
image: mobiledevops/flutter-sdk-image:3.10.3

stages:
    - build

release_build:
    stage: build
    tags:
      - shared
    script:
        - flutter build apk
```

Example Project: https://gitlab.com/mobiledevops/flutter-ci-demo

---

[Contributing](.github/CONTRIBUTING.md)

[Code of Conduct](.github/CODE_OF_CONDUCT.md)
