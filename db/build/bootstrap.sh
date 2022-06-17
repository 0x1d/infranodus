#!/usr/bin/env bash

. bootstrap.env

# Change the default neo4j password
# (default is 'neo4j', but needs changing before schema changes can be made!)
echo "CALL dbms.changePassword('$NEW_PASSWORD');" | cypher-shell -u $DEFAULT_USERNAME -p $DEFAULT_PASSWORD

# Setup indicies as per https://github.com/noduslabs/infranodus/wiki/Neo4J-Database-Setup
INDICIES="
  CREATE INDEX ON :User(name);
  CREATE INDEX ON :User(uid);
  CREATE INDEX ON :Concept(name);
  CREATE INDEX ON :Concept(uid);
  CREATE INDEX ON :Context(name);
  CREATE INDEX ON :Context(uid);
  CREATE INDEX ON :Context(by);
  CREATE INDEX ON :Statement(name);
  CREATE INDEX ON :Statement(uid);
"
echo $INDICIES | cypher-shell -u $DEFAULT_USERNAME -p $NEW_PASSWORD

# Setup automatic indexing as per https://github.com/noduslabs/infranodus/wiki/Setting-up-Automatic-Indexing-in-Neo4J-3.x
TRIGGERS="
  CALL apoc.trigger.add('RELATIONSHIP_INDEX',\"UNWIND {createdRelationships} AS r MATCH ()-[r]->() CALL apoc.index.addRelationship(r,['user','context','statement','gapscan']) RETURN count(*)\", {phase:'after'});
  CALL apoc.trigger.add('RELATIONSHIP_INDEX_REMOVE_TO',\"UNWIND {deletedRelationships} AS r MATCH ()-[r:TO]->() CALL apoc.index.removeRelationshipByName('TO',r) RETURN count(*)\", {phase:'after'});
  CALL apoc.trigger.add('RELATIONSHIP_INDEX_REMOVE_AT',\"UNWIND {deletedRelationships} AS r MATCH ()-[r:AT]->() CALL apoc.index.removeRelationshipByName('AT',r) RETURN count(*)\", {phase:'after'});
  CALL apoc.trigger.add('RELATIONSHIP_INDEX_REMOVE_BY',\"UNWIND {deletedRelationships} AS r MATCH ()-[r:BY]->() CALL apoc.index.removeRelationshipByName('BY',r) RETURN count(*)\", {phase:'after'});
  CALL apoc.trigger.add('RELATIONSHIP_INDEX_REMOVE_OF',\"UNWIND {deletedRelationships} AS r MATCH ()-[r:OF]->() CALL apoc.index.removeRelationshipByName('OF',r) RETURN count(*)\", {phase:'after'});
  CALL apoc.trigger.add('RELATIONSHIP_INDEX_REMOVE_IN',\"UNWIND {deletedRelationships} AS r MATCH ()-[r:IN]->() CALL apoc.index.removeRelationshipByName('IN',r) RETURN count(*)\", {phase:'after'});
"
echo $TRIGGERS | cypher-shell -u $DEFAULT_USERNAME -p $NEW_PASSWORD
