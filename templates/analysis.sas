/*!

    The file conducts a statistical analysis of dataset $DATA for the
    project $PROJECT (using the dataset generated from the variables.sas
    file).

    * @author $AUTHOR
    * @date $DATE

    */
run;

/**

    The for.sas macro allows looping through repetitive chunks of code
    in so-called "open code" by sas (as in, while in a datastep).  This is
    a read-only file, as it should not need to be edited. 

    */
%inc './functions/For.sas';
run;

/**

    File that contains all user-defined macros.  This is a read-only
    file; the original is found in github.com/lwjohnst86/sasToolkit.  If
    the file needs updating, using run `make refresh` in the parent
    directory of this project (i.e. $PROJECT/).  The master file should be
    in a different location, updating the copy using the makefile (`make
    refresh`) whenever the master file is changed.  For this project, the
    master macro files are located in $MACROS

    */
%inc './functions/macros.sas';
run;

/**

    Set various options for SAS.

    */
options nodate nonumber nocenter formdlim="" nolabel;
filename suppress dummy; * Suppress output;
filename temp temp; * Outputting results using user macros;
title; * Remove title from each page of output;
*options macrogen mlogic mprintnest symbolgen; * For debugging;
run;

/**************************************************/

/*

    The following command unzips the compressed dataset to use in sas. 
    
    */
%let ds = dataset;
%csvgz_import(dataset=../data/${PROJECT}_data.csv.gz,
    outds=&ds, dir=../data);
%contents(dataset=&ds);
run;

/* Macro variables for analyses */

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
    %let m3_c = &m2_c;
    %let m3_d = &m2_d;

/**************************************************/

/* Statistical tests */
