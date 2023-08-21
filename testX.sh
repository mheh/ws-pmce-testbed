#!/bin/sh

# first test, node server to node client
node ./node-ws-server/node/main.js > ./node-server-log.txt

node ./node-ws.client/main.js > ./node-client-log.txt

# second test, vapor client to node server
