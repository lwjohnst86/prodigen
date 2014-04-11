********************;
/* Set SAS options */
libname myfmtlib './functions';
options fmtsearch=(myfmtlib.formats);
options nodate nonumber nocenter formdlim="" nolabel;
*options macrogen mlogic mprintnest symbolgen; * For debugging;
filename suppress dummy; * Suppress output;
filename temp temp; * Outputting results using user macros;
title; * Remove title from each page of output;
run;

