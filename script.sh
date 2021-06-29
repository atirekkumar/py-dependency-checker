#!/bin/bash

# conda-pip incompatibility: https://stackoverflow.com/questions/50777849/from-conda-create-requirements-txt-for-pip3 , https://www.anaconda.com/blog/using-pip-in-a-conda-environment
# relevant to error message: http://5.9.10.113/63480238/deployment-in-heroku-fails-due-to-issue-in-requirements-txt
# Error message: ERROR: Could not install packages due to an EnvironmentError: [Errno 2] No such file or directory: '/home/conda/feedstock_root/build_artifacts/backcall_1592338393461/work'
# pip-freeze path problem: https://stackoverflow.com/questions/62885911/pip-freeze-creates-some-weird-path-instead-of-the-package-version/62886215#62886215

# check python version

# check existing dependencies
pip3 check

# to check a new package
if [[ $# -gt 0 ]]
then
    name="dependency145"
    # conda list -e > requirements.txt
    pip3 freeze > requirements.txt
    # pip3 list --format=freeze > requirements.txt
    # conda create --name $name
    # conda create --file requirements.txt
    # creating and entering venv
    python3 -m venv $name
    source $name/bin/activate
    # installing requirements
    echo "Installing pre-existing packages in virtualenv..."
    pip3 -q install -r requirements.txt
    echo "Done."
    # conda install --file requirements.txt
    echo "Installing $1"
    pip3 -q install $1
    echo "Done."
    # conda install $1
    pip3 check
    deactivate
    # deleting the venv
    rm -rf $name
    # deleting requirements.txt
    rm requirements.txt
fi    
