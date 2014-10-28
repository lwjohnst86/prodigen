/*!

    SAS Data Processing Script
    ==========================

    This SAS script will import the data from $DATA and keep or create
    variables relevant for analysis for the project $PROJECT.  The script
    will then create a project specific dataset that the analysis SAS and
    R script will analyze.
    
    * @author $AUTHOR
    * @created $DATE
    
    */
run;

/**

    SAS Options
    ===========

    Set up the SAS autocall command to be able to find and run macros
    stored in the personal SAS autocall library.  The macros used in this
    analysis can be found at github.com/$GITHUBUSER/$GITHUBSASPKG
    
    */
filename macrolib '$MACROSHOME';
options mautosource sasautos=(sasautos macrolib);

includeMacroFile

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

    Importing and Processing the Data
    =================================

    The following command unzips the compressed dataset to use in sas. 
    
    */
%let ds = working;
%csvgz_import(dataset=$DATASET,
    outds=&ds, dir=../data);
%contents(&ds);
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

%contents(&ds);

/**

    Exporting the New Dataset
    =========================

    Export the project specific dataset into csv.  Compress the new
    dataset and change to read-only.  Create a data directory if none
    exists.  Requires Unix OS.
    
    */
x "if [ ! -d ../data ] ; then mkdir ../data; fi";
proc export data=&ds
    outfile="../data/${PROJECT}_data.csv"
    dbms=csv
    replace;
run;

x 'gzip -f -9 ../data/${PROJECT}_data.csv;
chmod 444 ../data/${PROJECT}_data.csv.gz';
