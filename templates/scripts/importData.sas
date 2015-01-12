/*!

    Importing the Working Dataset
    =============================
    
    The following command unzips the compressed working (not the
    master) dataset to use in SAS.
    
    */
%let ds = $PROJECT;
%csvgz_import(dataset=../data/${PROJECT}_data.csv.gz,
    outds=&ds, dir=../data);
%contents(&ds);
run;
