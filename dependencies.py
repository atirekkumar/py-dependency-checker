import os
import subprocess

# function to refine the output from subprocess module to a usable list
def refine(output):
    output = str(output)
    output = output[2:]
    output = output[:-3]
    output = output.split('\\n')
    output = set(output)
    return output

# install pipdeptree
os.system("pip install pipdeptree")

# installed -> packages already installed, got using 'pip freeze'
installed = subprocess.check_output("pip freeze", shell=True)
installed = refine(installed)

# depedencies -> dependencies of the packages already installed, got using 'pipdeptree -fl'
dependencies = subprocess.check_output("pipdeptree -fl", shell=True)
dependencies = refine(dependencies)
dependencies = [w[2:] for w in dependencies if w[0] == ' ']

# removing pip as it does not appear in the 'pip freeze' command
dependencies = [w for w in dependencies if w[:5] != "pip=="]

# check if dependencies needed are present in installed 
for dependency in dependencies:
    if dependency not in installed:
        print(dependency)