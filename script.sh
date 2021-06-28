#!/bin/bash

# check existing dependencies
pip check

# to check a new package
if [[ $# -gt 0 ]]
then
    name="dependency"
#     pip freeze > requirements.txt
    conda install -e > requirements.txt
    # creating and entering venv
    python3 -m venv $name
    source $name/bin/activate
    # installing requirements
#     pip install -r requirements.txt
    conda install --file requirements.txt
    conda install $1
    pip check
    deactivate
    # deleting the venv
    rm -rf $name
    # deleting requirements.txt
    rm requirements.txt
fi    
