#!/usr/bin/env bash

## This script was created July 29, 2013, by Luke Johnston to fulfill
## the goal of creating a standardized research project directory tree.

## This script is to be used on the command-line.  A prompt will ask
## for a project name (without spaces).

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
## copied location, for example, the manuscript.md file in the .
SRC_DIR=$PROJ_BASE_DIR/scripts

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
cp -rv $TEMPLATES/* $PROJ_BASE_DIR/

## If the MACRO variable is empty, don't insert the file
## `includeMacroFile.sas` into both analysis.sas and variables.sas
## files.  If the MACRO variable is not empty, then insert the file so
## that the macros get loaded into the SAS file.  Then delete the file.
if [ -n "$MACROS" ]; then
    echo $SRC_DIR/includeMacroFile.sas >> $SRC_DIR/options.sas
fi
find $SRC_DIR -name includeMacroFile.sas -delete

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

## Remove any unnecessary files with '~' ending
find $PROJ_BASE_DIR -type f -iname '*~' -delete
