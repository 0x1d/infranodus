#!/bin/bash

APP=infranodus
#DATA_PATH=~/.shroud/$APP

##init          Initialize project
function init {
    mkdir -p import
    cp vagrant/setup-neo4j.sh import
    cp default.env .env
    cp config.json.sample config.json
    touch views/statsabove.ejs
    touch views/statsbelow.ejs
    touch views/statsheader.ejs
}

##build         Build with docker-compose
function build {
    docker-compose build
    docker-compose exec db bash -c "./import/setup-neo4j.sh"
}

function run {
    docker-compose up --remove-orphans --force-recreate --detach
    watch docker ps
}

function stop {
    docker-compose stop
}

function remove {
    docker-compose down
}

##vagrant:app   Run inside Vagrant
function vagrant:app {
    vagrant up ; vagrant ssh -- -t 'cd /vagrant; node app.js'
}

function info {
    clear
    echo "-------------------------------------------"
    echo "App:  ${APP}"
    echo "Data: ${DATA_PATH}"
    echo "-------------------------------------------"
    cat hosting.properties | grep VERSION
    echo "-------------------------------------------"
    sed -n 's/^##//p' ctl.sh
    echo "-------------------------------------------"
    docker ps | grep $APP
}

${@:-info}