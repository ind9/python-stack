# python-stack

Docker image that's used to build python apps using heroku compatible python buildpack. We use [herokuish](https://github.com/gliderlabs/herokuish) to run them. This is meant to be run as part of the build process in GoCD. The generated artifacts will be deployed on marathon.

## Usage
We expect the app material to be mounted on `/app` inside the container. After launching the container, the final slug tarball will be available as `app.tar.gz` inside the material folder.
