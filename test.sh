#!/bin/sh

docker run -it -v $(pwd):/app/buildpack:ro heroku/buildpack-testrunner
