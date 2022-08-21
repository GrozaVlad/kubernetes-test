#!/bin/bash
# build service A docker image
docker build ./btcExchangeRateApi -t service-a-node-web-app
# build service B docker image
docker build ./simpleRestApi -t service-b-node-web-app