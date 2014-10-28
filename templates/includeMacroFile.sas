/**

    File that contains all user-defined macros.  This is a read-only
    file; the original is found in github.com/$GITHUBUSER/$GITHUBSASPKG.  If
    the file needs updating, using run `make refresh` in the parent
    directory of this project (i.e. $PROJECT/).  The master file should be
    in a different location, updating the copy using the makefile (`make
    refresh`) whenever the master file is changed.  For this project, the
    master macro files are located in $MACROSHOME.

    */
%inc './functions/macros.sas';
run;
