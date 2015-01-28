#!/usr/bin/env bash

## This script was created July 29, 2013, by Luke Johnston to fulfill
## the goal of creating a standardized research project directory tree.

## This script is to be used on the command-line.  A prompt will ask
## for a project name (without spaces).

## Variables to be read into from user input
echo "Please enter a meaningful and short project name, without spaces:"
read project

echo "How you filled out the configuration file (pdg.conf)? yes/no"
read filled_conf

## Set where the template files are located
app=$(readlink -f "$0")
app_dir=$(dirname $app)
templates_man=$app_dir/templates/manuscript
templates_abs=$app_dir/templates/abstract

## Check answer to filled_conf and source the config_file
config_file=$app_dir/pdg.conf

if [[ $filled_conf = "yes" ]]; then 
    if [[ -f $config_file ]]; then
        echo Including file: $config_file
        source $config_file
    fi
else
    echo "Please fill out the config file with your information before proceeding"
    exit 1 # Exit with a failure
fi

## Set the project base directory
proj_dir=$research_dir/$project

## Check to make sure a folder doesn't already exist with the
## $project name
if [[ -d $proj_dir ]]
then
    echo "Error: Folder already exists."
    exit 1 ## Causes script to exit with a failure
else
    ## Remove any unnecessary files with '~' ending
    mkdir -v $proj_dir
fi

## Create main folders within research project folder
rsync -rv --exclude="*~" $templates_man/ $proj_dir/

## Change variable names throughout files to their proper names, as
## determined in the pdf.conf file
dataset=$data_dir/$data

find $proj_dir -type f -exec sed -i -e "s;((project));${project};g" \
    -e "s;((biblio));"${biblio}";g" \
    -e "s;((bibstyle));"${bibstyle}";g" \
    -e "s;((dataset));"${dataset}";g" \
    -e "s;((data));${data};g" \
    -e "s;((date));${date};g" \
    -e "s;((author));${author};g" \
    -e "s;((github_user));${github_user};g" \
    -e "s;((rpkg));${rpkg};g" \
    {} \;

## Create a PDF of the README file.
make -C $proj_dir readme

## Initiate a git repository.  Git is a version control system which
## allows tracking of changes made to the files and allows you to go
## back to previous versions of a file.  This is a very powerful and
## useful software for documenting what you did and why!
git -C $proj_dir init

## Create a file to tell git to ignore version controlling the given
## files EOF stands for end of file. The << creates a here-document
## that outputs all the text between the two EOF and inputs it into
## the > ./filename
cat > $proj_dir/.gitignore <<EOF
## This file tells git to ignore the following files and folders:
*~
.~*
output/
figure/
auto/
*.el
*.tex

EOF

## Add the files to be tracked by git
git -C $proj_dir add .

## Commit the first version
git -C $proj_dir commit -m "Project's first version commit."
