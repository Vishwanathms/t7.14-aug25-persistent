#!/bin/sh
set -e

# Replace the placeholder with the environment variable
envsubst '${WELCOME_MSG} ${ENV}' < /usr/share/nginx/html/index.html.template > /usr/share/nginx/html/index.html
