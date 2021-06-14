#!/bin/bash

APP=InfraNodus

function info {
    echo "-------------------------------------------"
    echo $APP
    echo "-------------------------------------------"
    cat .env | grep VERSION
    echo "-------------------------------------------"
}

function env:init {
    cp default.env .env
    cp config.json.sample config.json
    touch views/statsabove.ejs
    touch views/statsbelow.ejs
    touch views/statsheader.ejs
}

function app:init {
    docker-compose build
}

function app:run {
    docker-compose up --remove-orphans --force-recreate --detach
}

function app:stop {
    docker-compose stop
}

function db:bootstrap {
    chmod +x vagrant/setup-neo4j.sh
    docker-compose exec db bash -c "/vagrant/setup-neo4j.sh"
}

function vagrant:run {
    vagrant up ; vagrant ssh -- -t 'cd /vagrant; node app.js'
}
