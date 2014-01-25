*************************************************************;
/* This SAS script was created on $DATE by Luke Johnston. The file
    keeps and creates the relevant variables from ${DatasetName} for
    the project ${ProjectDir}. */

/* Include the options and macros */
    %inc './functions/options.sas';
    %inc './functions/For.sas';
    %inc './functions/macros.sas';
run;

/* The following command unzips the compressed dataset to use in sas. */
    %let ds = working;
    %csvgz_import(dataset=${DatasetName}_data, outds=&ds);
    %contents(dataset=&ds);
run;

/* Keep and create variables from the original dataset */
data &ds;
        * Keep relevant variables;
    set &ds
        (keep=);
run;

    %contents(dataset=&ds);

/* Export the newer, more relevant dataset into csv */
proc export data=&ds
    outfile="../dataset/${ProjectDir}_data.csv"
    dbms=csv
    replace;
run;

/* Compress the new dataset and change to read-only */
    x 'gzip -f -9 ../dataset/${ProjectDir}_data.csv; chmod 444 ../dataset/${ProjectDir}_data.csv.gz';
* likely requires UNIX;

