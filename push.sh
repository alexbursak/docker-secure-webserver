#!/usr/bin/env bash

ARG="$1"
TAG='latest'

if [[ -z "$ARG" ]]
then
    TAG='latest'
else
    TAG=$ARG
fi

docker push alexbursak/secure-webserver:"$TAG"