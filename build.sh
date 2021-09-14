#!/usr/bin/env bash

MY_PATH="`dirname \"$0\"`"

ARG="$1"

if [[ 'amd' != "$ARG" ]] && [[ 'arm' != "$ARG" ]]
then
  echo "ERROR: Invalid type - $ARG."
  exit
fi

if [[ -z "$ARG" ]]
then
    TYPE='amd'
    TAG='amd'
else
    TYPE=$ARG
    TAG=$ARG
fi

echo "Building WebServer image:"
echo "Architecuture - $TYPE"
echo "Tag - $TAG"
echo "-------------------------"

docker build -f "$TYPE".Dockerfile -t alexbursak/secure-webserver:"$TAG" .