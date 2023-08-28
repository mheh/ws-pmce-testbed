#!/bin/sh

declare -A Locations
Locations[node-client] = ./node-ws-client/
Locations[node-server] = ./node-ws-server/
Locations[vapor-server] = ./vapor_ws_server/
Locations[vapor-client] = ./vapor_ws_client/
Locations[go-client] = ./go_ws_client/
Locations[go-server] = ./go_ws_server/
Locations[nio-client] = ./nio_ws_client/
Locations[nio-server] = ./nio_ws_server/

if ![[ -e $Locations[node-client] ]]; then
  
  echo "Locations[node-client] not found at " + Locations[node-client]
else 
  echo "Located " + Locations[node-client]
fi
echo "Running node server against node client."
# first test, node server to node client
#node ./node-ws-server/main.js > ./node-nocde-server-log.txt

#node ./node-ws.client/main.js > ./node-node-client-log.txt

# second test, vapor client to vapor server
#cd ./vapor_ws_server/ 

#swift run App serve -b 0.0.0.0:0080 > ./vapor-vapor-server.txt
#cd ../vapor_ws_client/

#swift run App serve -b 0.0.0.0:8081 > ./vapor-vapoe-client.txt
