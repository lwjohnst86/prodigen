*********************************************************************;
/* This SAS script was created on $DATE by Luke Johnston.
/* The file conducts a statistical analysis of dataset ${DatasetName}
/* for the project ${ProjectDir} (using the dataset generated from the
/* variables.sas file. */

/* Include the options and macros */
    %inc './functions/options.sas';
    %inc './functions/For.sas';
    %inc './functions/macros.sas';
run;

/* Import dataset */
    %let ds = dataset;
    %csvgz_import(dataset=${ProjectDir}_data, outds=&ds);
    %contents(dataset=&ds);
run;

/** Macro variables for analyses **/

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
    %let m4_c = &m3_c;
    %let m4_d = &m3_d;

*************************;
/** Statistical tests **/
