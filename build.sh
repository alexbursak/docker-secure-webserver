#!/usr/bin/env bash

MY_PATH="`dirname \"$0\"`"

ARG="$1"
TAG='latest'

if [[ -z "$ARG" ]]
then
    TAG='latest'
else
    TAG=$ARG
fi

docker build -t alexbursak/secure-webserver:"$TAG" "$MY_PATH"