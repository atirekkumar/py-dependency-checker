#!/bin/bash

# conda-pip incompatibility: https://stackoverflow.com/questions/50777849/from-conda-create-requirements-txt-for-pip3 , https://www.anaconda.com/blog/using-pip-in-a-conda-environment
# relevant to error message: http://5.9.10.113/63480238/deployment-in-heroku-fails-due-to-issue-in-requirements-txt
# Error message: ERROR: Could not install packages due to an EnvironmentError: [Errno 2] No such file or directory: '/home/conda/feedstock_root/build_artifacts/backcall_1592338393461/work'
# pip-freeze path problem: https://stackoverflow.com/questions/62885911/pip-freeze-creates-some-weird-path-instead-of-the-package-version/62886215#62886215
# ERROR: "Could not find a version that satisfies the requirement". This error can be caused by the package version being required not matching with the installed python or pip version
# check python version

# check existing dependencies
pip3 check

# to check a new package
if [[ $# -gt 0 ]]
then
    name="dependency145"
    pip_version=20.1
    pip3 freeze > requirements.txt
    pip3 install virtualenv
    # creating and entering venv
    # venv cannot edit the python version being used. Hence to use a different python version, use virtualenv or conda(preferred)
    python3 -m venv $name
    # conda create -n $name python=3.5
    source $name/bin/activate
    # conda activate $name

    # get correct pip version
    # https://stackoverflow.com/questions/21099057/control-the-pip-version-in-virtualenv
    curl https://bootstrap.pypa.io/pip/3.5/get-pip.py -o get-pip.py
    python3 get-pip.py pip==$pip_version  # also check if pip 8.1.1 is downloaded and can be deleted

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
