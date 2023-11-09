#!/bin/bash

parameter=$1
charts=(backend frontend database)

function apply() {
    for chart in "${charts[@]}"
    do
        echo "$chart"

        if $install
        then
            helm install ${chart}-app ${chart}-groupe1-chart
            kubectl apply -f ingress.yml
        else
            helm uninstall ${chart}-app
        fi
    done
}

if [[ "$1" = "-d" ]]
then
    echo "-------------Uninstall..."
    install=false
    apply

elif [[ "$1" = "-a" ]]
then
    echo "-------------Install...."
    install=true
    apply
else
    echo "Nothing to do...."

fi