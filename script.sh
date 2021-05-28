#!/bin/bash

# check existing dependencies
pip check

# to check a new package
if [[ $# -gt 0 ]]
then
    name="dependency"
    pip freeze > requirements.txt
    # creating and entering venv
    python3 -m venv $name
    source $name/bin/activate
    # installing requirements
    pip install -r requirements.txt
    pip install $1
    pip check
    deactivate
    # deleting the venv
    rm -rf $name
    # deleting requirements.txt
    rm requirements.txt
fi    