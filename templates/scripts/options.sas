/*!
    SAS Options
    ===========

    Set up the SAS autocall command to be able to find and run macros
    stored in the personal SAS autocall library.  The macros used in this
    analysis can be found at github.com/$GITHUBUSER/$GITHUBSASPKG
    
    */
filename macrolib '$MACROSHOME';
options mautosource sasautos=(sasautos macrolib);

options nodate nonumber nocenter formdlim="" nolabel;
filename suppress dummy; * Suppress output;

title ''; * Remove title from each page of output;
footnote '';

includeMacroFile
