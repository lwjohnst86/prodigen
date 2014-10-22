/*!

    SAS Statistical Analysis Script
    ===============================

    The file conducts a statistical analysis of dataset $DATA for the
    project $PROJECT (using the dataset generated from the variables.sas
    file).

    * @author $AUTHOR
    * @date $DATE

    */
run;

/**

    SAS Options
    ===========

    Set up the SAS autocall command to be able to find and run macros
    stored in the personal SAS autocall library.  The macros used in this
    analysis can be found at github.com/$GITHUBUSER/$GITHUBSASPKG
    
    */
filename macrolib '$MACROSHOME/';
options mautosource sasautos=(sasautos macrolib);

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

/**

    Set various options for SAS.

    */
options nodate nonumber nocenter formdlim="" nolabel;
filename suppress dummy; * Suppress output;
title ''; * Remove title from each page of output;
footnote '';
*options nosource nonotes; *Reduce output to log;
*options macrogen mlogic mprintnest symbolgen; * For debugging;
run;

**************************************************;


/**

    Macro Variables
    ===============

    Setting custom macro variables for analyses.

    */

    %let dir = ./; * Set working directory;

    %let cvar = ; * list of all continuous variables;
    %let dvar = ; * list of all discrete variables;

    ** Regression variables **;
    %let dep_d = ; * list of discrete dependents;
    %let dep_c = ; * list of continuous dependents;
    %let indep = ;
    
    %let m1_c = ;
    %let m1_d = ;
    %let m2_c = &m1_c ;
    %let m2_d = &m1_d ;

run;

**************************************************;

/*

    Importing the Dataset
    =====================
    
    The following command unzips the compressed dataset to use in sas. 
    
    */
%let ds = dataset;
%csvgz_import(dataset=../data/${PROJECT}_data.csv.gz,
    outds=&ds, dir=../data);
%contents(&ds);
run;

**************************************************;

/**

    Statistical Analysis
    ====================
    
    */
