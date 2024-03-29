#!/usr/bin/env bash

MY_PATH="`dirname \"$0\"`"

ARG="$1"

if [[ 'amd' != "$ARG" ]] && [[ 'arm' != "$ARG" ]]
then
  echo "ERROR: Invalid type - $ARG."
  exit
fi

if [[ "$ARG" == 'amd' ]]
then
    TYPE='amd'
    TAG='amd'
    PLATFORM='linux/amd64'
else
    TYPE=$ARG
    TAG=$ARG
    PLATFORM='linux/arm/v7'
fi

echo "Building WebServer image:"
echo "Architecuture - $TYPE"
echo "Tag - $TAG"
echo "-------------------------"

docker buildx build -f "$TYPE".Dockerfile -t alexbursak/secure-webserver:"$TAG" --platform "$PLATFORM" --load .
