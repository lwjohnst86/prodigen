/*!

    This SAS script will import the data from $DATA and keep or create
    variables relevant for analysis for the project $PROJECT.  The script
    will then create a project specific dataset that the analysis SAS and
    R script will analyze.
    
    * @author $AUTHOR
    * @created $DATE
    
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
    file; the original is found in ~/SAS/src/macros.  If the file needs
    updating, using run `make refresh` in the parent directory of this
    project (i.e. epaDiabetes/).  The master file should be in a different
    location, updating the copy using the makefile (`make refresh`)
    whenever the master file is changed.  For this project, the master
    $MACROS file is

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
%let ds = working;
%csvgz_import(dataset=$DATASET,
    outds=&ds, dir=../data);
%contents(dataset=&ds);
run;

/**

    Keep and create variables from the original dataset that will be
    output to another dataset used by the analysis scripts.
    
    */
data &ds;
        * Keep relevant variables;
    set &ds
        (keep=);
run;

%contents(dataset=&ds);

/**

    Export the project specific dataset into csv.  Compress the new
    dataset and change to read-only. Requires Unix OS.
    
    */
x "if [ ! -d ../data ] ; then mkdir ../data; fi";
proc export data=&ds
    outfile="../data/${PROJECT}_data.csv"
    dbms=csv
    replace;
run;

x 'gzip -f -9 ../data/${PROJECT}_data.csv;
chmod 444 ../data/${PROJECT}_data.csv.gz';
