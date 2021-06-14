#!/usr/bin/env bash

# Update Neo4j config to support APOC, then restart Neo4j
echo "apoc.trigger.enabled=true" >> /etc/neo4j/neo4j.conf
service neo4j restart
sleep 15s   # Wait 15s to let the neo4j service restart!
