/*!

    SAS Statistical Analysis Script
    ===============================

    The file conducts a statistical analysis of dataset $DATA for the
    project $PROJECT (using the dataset generated from the variables.sas
    file).

    * @author $AUTHOR
    * @date $DATE

    */
%include 'options.sas';
filename macrolib '/home/luke/SAS/sasToolkit/src';
options mautosource sasautos=(sasautos macrolib);
options nosource nonotes; *Reduce output to log;
options macrogen mlogic mprintnest symbolgen; * For debugging;
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
    
run;

**************************************************;

%inc 'importData.sas';

**************************************************;

/**

    Statistical Analysis
    ====================
    
    */



**************************************************;

* Process the results, renaming variables, etc.;
%inc 'postProcessing.sas';

**************************************************;

%put DONE! Finished running code.;
