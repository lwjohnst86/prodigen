#!/usr/bin/env bash

## This script was created July 29, 2013, by Luke Johnston to fulfill
## the goal of creating a standardized research project directory tree.

## This script is to be used on the command-line by changing the
## directory to the current folder ("cd ~/Documents/research-project")
## and typing "sh createprojdir").  A prompt will ask for a project
## name (without spaces) and for the dataset name (a file located in
## ~/Documents/datasets ending in "_data.csv". At the prompt enter the
## dataset name without the _data.csv ending, i.e. type PROMISE for the
## PROMISE_data.csv file).

## Variables to be read into from user input
echo "Please enter a meaningful and short project name, without spaces:"
read PROJECT
echo "How you filled out the configuration file (pdg.conf)? yes/no"
read FILLEDCONF

## Set where the template files are located
SCRIPT=$(readlink -f "$0")
SCRIPTDIR=$(dirname $SCRIPT)
TEMPLATES=$SCRIPTDIR/templates
echo $SCRIPT
echo $SCRIPTDIR
echo $TEMPLATES

## Check answer to FILLEDCONF and source the CONFIG_FILE
CONFIG_FILE=$SCRIPTDIR/pdg.conf

if [[ $FILLEDCONF = "yes" ]]
then 
    if [[ -f $CONFIG_FILE ]]
    then
        echo $CONFIG_FILE
        . $CONFIG_FILE
    fi
else
    echo "Please fill out the config file with your information before proceeding"
    exit 1 # Exit with a failure
fi

## Change directory to where your research projects are located
cd $RESEARCHDIR


## Check to make sure a folder doesn't already exist with the
## $PROJECT name
if [[ -d $PROJECT ]]
then
    echo "Error: Folder already exists."
    exit 1 ## Causes script to exit with a failure
else
    mkdir -v $PROJECT && cd ./"$_"
    ## The "$_" = using the first argument of the previous command
    pwd
fi

## Create main folders within research project folder
for dir in ${DIRTREE[@]}
do
    mkdir -vp $dir
done

## Copy dataset to project directory
cp -p $DATASET ./data

## Copy functions and macros to project, chmod to read-only (444).
## Only the master files can be edited, with these copies able to be
## updated using the makefile (make referesh)
for i in $FUNCTIONS $MACROS; do
    cp -fvu $i scripts/functions
done
chmod 444 ./scripts/functions/*.{sas,R}

## Copy the template files from the `Template` folder to the project
for i in README.md Makefile; do 
    cp -fvu $TEMPLATES/$i .
done

for i in manuscript.md; do
    cp -fvu $TEMPLATES/$i report
done

for i in variables.sas analysis.sas analysis.R; do
    cp -fvu $TEMPLATES/$i scripts
done

cp -fvu $TEMPLATES/mindmap.mm lit/mindmap/mindmap.mm

cat > TODO.org <<EOF
* Task list

EOF

cat > ideas.md <<EOF
# Potential ideas for analysis #

EOF

find . -type f -exec  sed -i -e 's/\$PROJECT/'$PROJECT'/g' \
    -e 's/\${PROJECT}/'$PROJECT'/g' \
    -e 's;\$BIBLIO;'$BIBLIO';g' \
    -e 's;\$BIBSTYLE;'$BIBSTYLE';g' \
    -e 's;\$DATASET;'$DATASET';g' \
    -e 's/\$DATA/'$DATA'/g' \
    -e 's/\$DATE/'$DATE'/g' \
    -e 's/\$AUTHOR/'"$AUTHOR"'/g' \
    -e 's;\$MACROS;'$MACROS';g' \
    -e 's;\$FUNCTIONS;'$FUNCTIONS';g' \
    {} \;

## Create a PDF of the README file.
pandoc README.md -V geometry:margin=1in \
    -V mainfont="DejaVu Serif" \
    -V fontsize=12pt \
    -o README.pdf

## Output to screen the entire directory structure
ls -R

## Initiate a git repository.  Git is a version control system which
## allows tracking of changes made to the files and allows you to go
## back to previous versions of a file.  This is a very powerful and
## useful software for documenting what you did and why!
git init

## Create a file to tell git to ignore version controlling the given
## files EOF stands for end of file. The << creates a here-document
## that outputs all the text between the two EOF and inputs it into
## the > ./filename
cat > .gitignore <<EOF
## This file tells git to ignore the following files and folders:
*~
.~*
output/
EOF

## Add the files to be tracked by git
git add .

## Commit the first version
git commit -m "Project's first version commit."
