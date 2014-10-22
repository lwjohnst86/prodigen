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
APP=$(readlink -f "$0")
APPDIR=$(dirname $APP)
TEMPLATES=$APPDIR/templates

## Check answer to FILLEDCONF and source the CONFIG_FILE
CONFIG_FILE=$APPDIR/pdg.conf

if [[ $FILLEDCONF = "yes" ]]; then 
    if [[ -f $CONFIG_FILE ]]; then
        echo $CONFIG_FILE
        . $CONFIG_FILE
    fi
else
    echo "Please fill out the config file with your information before proceeding"
    exit 1 # Exit with a failure
fi

## Set the project base directory
PROJ_BASE_DIR=$RESEARCHDIR/$PROJECT

## Set a shell variable with all of the template files and their
## copied location (for example, the manuscript.md file in the .
REP_DIR=$PROJ_BASE_DIR/report
SRC_DIR=$PROJ_BASE_DIR/scripts
FUN_DIR=$SRC_DIR/functions
LIT_DIR=$PROJ_BASE_DIR/lit
MM_DIR=$LIT_DIR/mindmap

TMPLT_FILES="
    $PROJ_BASE_DIR/README.md 
    $PROJ_BASE_DIR/Makefile 
    $REP_DIR/manuscript.md 
    $SRC_DIR/01-variables.sas 
    $SRC_DIR/02-analysis.sas 
    $SRC_DIR/03-plots.R 
    $REP_DIR/options.tex 
    $LIT_DIR/searchStrategy+Issues.md 
    $MM_DIR/mindmap.mm
"

## Check to make sure a folder doesn't already exist with the
## $PROJECT name
if [[ -d $PROJ_BASE_DIR ]]
then
    echo "Error: Folder already exists."
    exit 1 ## Causes script to exit with a failure
else
    mkdir -v $PROJ_BASE_DIR
fi

## Create main folders within research project folder
for dir in ${DIRTREE[@]}; do
    mkdir -vp $PROJ_BASE_DIR/$dir
done

## Copy functions and macros to project, chmod to read-only (444).
## Only the master files can be edited, with these copies able to be
## updated using the makefile (make referesh)
if [ -n "$FUNCTIONS" -o -n "$MACROS" ]; then
    for func in $FUNCTIONS $MACROS; do
        cp -fvu $func $FUN_DIR/$(basename $func)
    done
fi
chmod 444 $FUN_DIR/*

## Copy the template files from the `Template` folder to the project
for file in $TMPLT_FILES; do
    cp -fvu $TEMPLATES/$(basename $file) $file
done

## Create TODO and ideas.md files
cat > $PROJ_BASE_DIR/TODO.org <<EOF
* Task list

EOF

cat > $PROJ_BASE_DIR/ideas.md <<EOF
# Potential ideas for analysis #

EOF

## Change variable names throughout files to their proper names, as
## determined in the pdf.conf file
find $PROJ_BASE_DIR -type f -exec  sed -i -e 's/\$PROJECT/'$PROJECT'/g' \
    -e 's/\${PROJECT}/'$PROJECT'/g' \
    -e 's;\$BIBLIO;'$BIBLIO';g' \
    -e 's;\$BIBSTYLE;'$BIBSTYLE';g' \
    -e 's;\$DATASET;'$DATASET';g' \
    -e 's/\$DATA/'$DATA'/g' \
    -e 's/\$DATE/'$DATE'/g' \
    -e 's/\$AUTHOR/'"$AUTHOR"'/g' \
    -e 's;\$MACROSHOME;'$MACROSHOME';g' \
    -e 's;\$MACROS;'$MACROS';g' \
    -e 's;\$GITHUBUSER;'$GITHUBUSER';g' \
    -e 's;\$GITHUBRPKG;'$GITHUBRPKG';g' \
    -e 's;\$GITHUBSASPKG;'$GITHUBSASPKG';g' \
    -e 's;\$FUNCTIONS;'$FUNCTIONS';g' \
    {} \;

## Create a PDF of the README file.
make -C $PROJ_BASE_DIR readme

## Output to screen the entire directory structure
ls -R $PROJ_BASE_DIR

## Initiate a git repository.  Git is a version control system which
## allows tracking of changes made to the files and allows you to go
## back to previous versions of a file.  This is a very powerful and
## useful software for documenting what you did and why!
git -C $PROJ_BASE_DIR init

## Create a file to tell git to ignore version controlling the given
## files EOF stands for end of file. The << creates a here-document
## that outputs all the text between the two EOF and inputs it into
## the > ./filename
cat > $PROJ_BASE_DIR/.gitignore <<EOF
## This file tells git to ignore the following files and folders:
*~
.~*
output/
*.el
*/auto/
*.tex
!options.tex
EOF

## Add the files to be tracked by git
git -C $PROJ_BASE_DIR add .

## Commit the first version
git -C $PROJ_BASE_DIR commit -m "Project's first version commit."
