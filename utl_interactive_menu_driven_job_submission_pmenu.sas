Interactive menu driven job submission pmenu

If you crosspost to SAS-L I will respond faster

for submission screen
https://tinyurl.com/y8mxfqa2
https://github.com/rogerjdeangelis/utl_interactive_menu_driven_job_submission_pmenu/blob/master/utl_interactive_menu_driven_job_submission_pmenu.png

github
https://github.com/rogerjdeangelis/utl_interactive_menu_driven_job_submission_pmenu

SAS Forum
https://communities.sas.com/t5/ODS-and-Base-Reporting/Create-app-from-htmls/m-p/470262

Allows the submission of mixtures of config file driven or
macro argument driven asubsets of up 50 programs

After running your programs you may
need to highlight and run.

dm "pmenu off";

HOW TO RUN
===========

Programs can run be by clicking a progam in a list of programs

Initial screen

+------+---------------+---------+
| File | Macro Driver  | Window  |
+------+---------------+---------+

Click on Macro Driver

+-------------------+
|                   |
|  +---+            |
|  |   |  Objects   |
|  +---+            |
|                   |
|  +---+            |
|  |   |  END       |
|  +---+            |
|                   |
|   QUIT            |
|                   |
+-------------------+

Click on Objects

+----------------------------------------+
| Objects                                |
+----------------------------------------+
|                                        |
|  +---+                                 |
|  |   |  Region   Region Level Reports  |
|  +---+                                 |
|                                        |
|  +---+                                 |
|  |   |  District District Level Report |
|  +---+                                 |
|                                        |
|   QUIT        CANCEL                   |
|                                        |
+----------------------------------------+


INPUT
=====

 Three methods for passing arguments to programs

  1. Configuration file driven

     Region program arguments in configuration file

     /home/xxxxxx/rjd/cnf.txt

      #region
      uobj     region
      uin      /dev/rmt/1n
      uprn     no
      ulog     /poisons/monthly/utl02oa.log
      udte     199410
      utitle   SRA File

      #district
      ....

     %utlmcro
            (
             unobj=2,

             uobj1=region,   /* runs macro region *
             udes1=Region level Report,
             ustrx1=%str(region
             ucnf   = c:\temp\cnf.txt   /* use config file */
                         )
                        )
  2. Inline argument driven

     %utlmcro
       (
        unobj=2,

        uobj1=region,
        udes1=Region level Report,
        ustrx1=%str(region
                    (
                     udes   = Region report,
                     uobj   = region,
                     udate  = June 96,
                     uin    = sashelp.class,
                     uot    = region,
                     ucnf   = no
                    )
                   )

                        )
  3. Default argument driven

     %utlmcro
       (
        unobj=2,

        uobj1=region,
        udes1=Region level Report,
        ustrx1=%str(region)
        )

 EXAMPLE PROGRAM

/* one program uses the config file and the other does not */
%macro region
       (
         udes   = Region level report,
         uobj   = region,
         udate  = June 96,
         uin    = sashelp.class,
         uot    = region,
         ucnf   = c:\temp\cnf.txt   /* config file             */
                                   /* "no" to turn off config */
        )/des ="Region Reports";
  /*----------------------------------------------*\
  |  utlprse parses the config file and overwrites |
  |  some or all of the macro arguments            |
  |  whatever is in the config file                |
  \*----------------------------------------------*/
      %put *** &ucnf ***;
      %if  %qupcase(&ucnf) ne NO %then %do;
            %utlprse
                (
                 ugetobj = &uobj,
                 ucnf    = &ucnf );
      %end;
      data class;
        set sashelp.class;
        if sex='M';
        dte="&udate";
        put dte=;
      run;
      /* date should be from config file not this macro */
      title "&udate &uobj &udes";
      proc print data=class;
      run;
%mend region;


PROCESS
=======

Programs can run be by clicking a progam in a list of programs

Initial screen

+------+---------------+---------+
| File | Macro Driver  | Window  |
+------+---------------+---------+

Click on Macro Driver
                          *
+-------------------+
|                   |
|  +---+            |
|  |   |  Objects   |
|  +---+            |
|                   |
|  +---+            |
|  |   |  END       |
|  +---+            |
|                   |
|   QUIT            |
|                   |
+-------------------+

Click on Objects

+----------------------------------------+
| Objects                                |
+----------------------------------------+
|                                        |
|  +---+                                 |
|  |   |  Region   Region Level Reports  |
|  +---+                                 |
|                                        |
|  +---+                                 |
|  |   |  District District Level Report |
|  +---+                                 |
|                                        |
|   QUIT        CANCEL                   |
|                                        |
+----------------------------------------+

* __       _ _             _       _   _
 / _|_   _| | |  ___  ___ | |_   _| |_(_) ___  _ __
| |_| | | | | | / __|/ _ \| | | | | __| |/ _ \| '_ \
|  _| |_| | | | \__ \ (_) | | |_| | |_| | (_) | | | |
|_|  \__,_|_|_| |___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

/* For 'config file' driven macro driver submission system */

   You will need to change the following

   %let cnf=c:\temp\cnf.txt; - location of config file

   If you set ucnf=no then the arguments in the driver macro will be used
   If you set ucnf=c:\temp\cnf.txt then the arguments in the driver overwritten by the config file


%macro utlmcro
       (
        unobj=5,
        umenu=sasuser.menus.main,
        usubset=Master Interactive Macro Driver,
        udes1=Ld Table,  uobj1=XXXXXXXX,  ustrx1=xeq1,
        udes2=Ld Table,  uobj2=XXXXXXXX,  ustrx2=xeq2,
        udes3=Ld Table,  uobj3=XXXXXXXX,  ustrx3=xeq3,
        udes4=Ld Table,  uobj4=XXXXXXXX,  ustrx4=xeq4,
        udes5=Ld Table,  uobj5=XXXXXXXX,  ustrx5=xeq5,
        udes6=Ld Table,  uobj6=XXXXXXXX,  ustrx6=xeq6,
        udes7=Ld Table,  uobj7=XXXXXXXX,  ustrx7=xeq7,
        udes8=Ld Table,  uobj8=XXXXXXXX,  ustrx8=xeq8,
        udes9=Ld Table,  uobj9=XXXXXXXX,  ustrx9=xeq9,
        udes10=Ld Table, uobj10=XXXXXXXX, ustrx10=xeq10,
        udes11=Ld Table, uobj11=XXXXXXXX, ustrx11=xeq11,
        udes12=Ld Table, uobj12=XXXXXXXX, ustrx12=xeq12,
        udes13=Ld Table, uobj13=XXXXXXXX, ustrx13=xeq13,
        udes14=Ld Table, uobj14=XXXXXXXX, ustrx14=xeq14,
        udes15=Ld Table, uobj15=XXXXXXXX, ustrx15=xeq15,
        udes16=Ld Table, uobj16=XXXXXXXX, ustrx16=xeq16,
        udes17=Ld Table, uobj17=XXXXXXXX, ustrx17=xeq17,
        udes18=Ld Table, uobj18=XXXXXXXX, ustrx18=xeq18,
        udes19=Ld Table, uobj19=XXXXXXXX, ustrx19=xeq19,
        udes20=Ld Table, uobj20=XXXXXXXX, ustrx20=xeq20,
        udes21=Ld Table, uobj21=XXXXXXXX, ustrx21=xeq21,
        udes22=Ld Table, uobj22=XXXXXXXX, ustrx22=xeq22,
        udes23=Ld Table, uobj23=XXXXXXXX, ustrx23=xeq23,
        udes24=Ld Table, uobj24=XXXXXXXX, ustrx24=xeq24,
        udes25=Ld Table, uobj25=XXXXXXXX, ustrx25=xeq25,
        udes26=Ld Table, uobj26=XXXXXXXX, ustrx26=xeq26,
        udes27=Ld Table, uobj27=XXXXXXXX, ustrx27=xeq27,
        udes28=Ld Table, uobj28=XXXXXXXX, ustrx28=xeq28,
        udes29=Ld Table, uobj29=XXXXXXXX, ustrx29=xeq29,
        udes30=Ld Table, uobj30=XXXXXXXX, ustrx30=xeq30,
        udes31=Ld Table, uobj31=XXXXXXXX, ustrx31=xeq31,
        udes32=Ld Table, uobj32=XXXXXXXX, ustrx32=xeq32,
        udes33=Ld Table, uobj33=XXXXXXXX, ustrx33=xeq33,
        udes34=Ld Table, uobj34=XXXXXXXX, ustrx34=xeq34,
        udes35=Ld Table, uobj35=XXXXXXXX, ustrx35=xeq35,
        udes36=Ld Table, uobj36=XXXXXXXX, ustrx36=xeq36,
        udes37=Ld Table, uobj37=XXXXXXXX, ustrx37=xeq37,
        udes38=Ld Table, uobj38=XXXXXXXX, ustrx38=xeq38,
        udes39=Ld Table, uobj39=XXXXXXXX, ustrx39=xeq39,
        udes40=Ld Table, uobj40=XXXXXXXX, ustrx40=xeq40,
        udes41=Ld Table, uobj41=XXXXXXXX, ustrx41=xeq41,
        udes42=Ld Table, uobj42=XXXXXXXX, ustrx42=xeq42,
        udes43=Ld Table, uobj43=XXXXXXXX, ustrx43=xeq43,
        udes44=Ld Table, uobj44=XXXXXXXX, ustrx44=xeq44,
        udes45=Ld Table, uobj45=XXXXXXXX, ustrx45=xeq45,
        udes46=Ld Table, uobj46=XXXXXXXX, ustrx46=xeq46,
        udes47=Ld Table, uobj47=XXXXXXXX, ustrx47=xeq47,
        udes48=Ld Table, uobj48=XXXXXXXX, ustrx48=xeq48,
        udes49=Ld Table, uobj49=XXXXXXXX, ustrx49=xeq49,
        udes50=Ld Table, uobj50=XXXXXXXX, ustrx50=xeq50
       )
       / des = "Interactive macro driver";

 /*----------------------------------------------*\
 |  Execute user selected macros using pmenus     |
 |  SUN Solaris 2.5 SAS 611                       |
 |  User can select any combination of up to 50   |
 |  macros to execute interactively.              |
 |  IPO                                           |
 |   Input:                                       |
 |    unobj:                                      |
 |    =====                                       |
 |    Up to 50 macro invocations. The sum of      |
 |    text in the 50 invocations must be          |
 |    less than 32k characters.                   |
 |    uobj:                                       |
 |    ====                                        |
 |     Text placed next to pmenu checkbox         |
 |    ustrx:                                      |
 |    =====                                       |
 |     macro invocation without percent sign      |
 \*----------------------------------------------*/

%let afstr1=;

%macro utlrunts;

   %let ujj=1;

   %do %until("%scan(&x,&ujj,' ')"="");
          %let unrn=%scan(&x,&ujj,' ');
          %let urun=%scan(&afstr1,&unrn,'{');

          %&urun;;

          %let ujj=%eval(&ujj + 1);
       %end;
   %mend utlrunts;

   dm "pmenu on";

    %let uchkbx=&&1;
    %let afstr1=&ustrx1;

    %do ujj=2 %to &unobj;

        %let uchkbx=&uchkbx &&&ujj;
        %let afstr1=&afstr1 { &&ustrx&ujj;

    %end;

   dm "pmenu on";

   proc pmenu catalog=sasuser.menus;
      menu main;

      item 'File' menu=file;
      item "&usubset" menu=rob;

      menu file;
      item 'end';

      menu rob;
      item 'Objects' dialog=rob;
      item 'end';
      dialog rob "end;%%let x=%str(&uchkbx);submit '%%utlrunts';";

      %let upos=1;

      %do un=1 %to &unobj;
          text     #&upos @7  "&&uobj&un";
          text     #&upos @17 "&&udes&un";
          checkbox #&upos @1  "&un";

          %let upos=%eval(&upos+1);
      %end;
   quit;
   run;

   %window DEVEL menu=sasuser.menus.main
      #1 @1 ' ';
     %display DEVEL;
   quit;
   run;

%mend utlmcro;

****     *    ****    ***   *****  ****
*   *   * *   *   *  *   *  *      *   *
*   *  *   *  *   *   *     *      *   *
****   *****  ****     *    ****   ****
*      *   *  * *       *   *      * *
*      *   *  *  *   *   *  *      *  *
*      *   *  *   *   ***   *****  *   *;

%macro utlprse(
    ugetobj = region,
    ucnf    =c:\temp\cnf.txt
              ) /des="utlprse parses config files";

 /*---------------------------------------*\
 |  Driving your code using 'config'       |
 |  files                                  |
 |  Object utlprse parses config files.    |
 |  This object Overwrites keyword macro   |
 |  variables                              |
 \*---------------------------------------*/

 /*---------------------------------------*\
 |  IPO                                    |
 |   Author Roger DeAngelis  28FEB95       |
 |   Input -- Object Name region  (macro). |
 |            Config file.                 |
 |   Process- Overwrites the default macro |
 |            arguments for object ugetobj.|
 |            This will allow objects to   |
 |            run interactively/batch and  |
 |            multiplatform OS/2, VMS, MVS,|
 |            Unix etc without any code    |
 |            changes. Only changes in     |
 |            a config file or object      |
 |            call arguments.              |
 |   Output-  Object (macro) argument      |
 |            settings.                    |
 \*---------------------------------------*/

 /*---------------------------------------*\
 |                                         |
 |  Config file must have a section        |
 |  like this                              |
 |                                         |
 |  #region                                |
 |  uobj     region                        |
 |  uin      /dev/rmt/1n                   |
 |  uprn     no                            |
 |  ulog     /poisons/monthly/utl02oa.log  |
 |  udte     199410                        |
 |  utitle   SRA File                      |
 |  #region                                |
 |                                         |
 \*---------------------------------------*/

 /*---------------------------------------*\
 |  Usage:                                 |
 |  Note utlprse resets uin,uvol .. etc    |
 |                                         |
 |  %macro utl02oa(                        |
 |    ucnf=/home/deangel/cnf.txt           |
 |    uin=/dev/rmt/1n,                     |
 |    uvol=129456,                         |
 |    uobj=utl02oa,                        |
 |    .                                    |
 |    utitl=SRA file                       |
 |         )                               |
 |                                         |
 |  %if &ucnf ne no %then                  |
 |                                         |
 |  %utlprse(                              |
 |    umem=&uobj,                          |
 |    ucnf=&uobj                           |
 |          );                             |
 |                                         |
 |  After utlprse has executed only those  |
 |  arguments common to the config file    |
 |  and object utl02oa are changed.        |
 \*---------------------------------------*/

data _null_;
 length uargx $ 9 uvalx $ 200;
 infile "&ucnf" length=lrec;
 /*---------------------------------------*\
 |  Find Object ugetobj arguments           |
 \*---------------------------------------*/
 do until (uargw="#&ugetobj");
  input record $varying200. lrec;
  if lrec gt 0 then uargw = scan( record, 1 );
 end;
 /*---------------------------------------*\
 |  Get Macro Var name and values          |
 \*---------------------------------------*/
 do until (uargx="#&ugetobj");
  input record $varying200. lrec;
  uargx = scan( record, 1 );
  temp  = scan( record, 2, ' ');
  if  temp ne "" then do;
      uvalx = substr( record, indexw( record, temp ) );
      call symputx ( uargx, uvalx );
  end;
end;
stop;
run
/*----------------------------------------------*\
|  Do not put a semicolon after the run          |
\*----------------------------------------------*/
%mend utlprse;

 ***    ***   *   *  *****  *****   ***
*   *  *   *  **  *  *        *    *   *
*      *   *  * * *  *        *    *
*      *   *  *  **  ****     *    * ***
*      *   *  *   *  *        *    *   *
*   *  *   *  *   *  *        *    *   *
 ***    ***   *   *  *      *****   ***;

/* normally the file below would be reside in a config folder and would
   be edited each for each monthly submission */
%let cnf=c:\temp\cnf.txt;
Data _null_;
input;
file "&cnf";
put _infile_;
cards4;
#Sample Config File for Monthly Processing of XYZ Inc Widget Sales

#This is file /home/xxxxxx/rjd/cnf.txt

#---------------------------------------
# Region Widget Reports
#---------------------------------------

#region
udes      Region Level Report
udate     July 99
uin       sashelp.class
uot       region
#region

#---------------------------------------
# District Widget Reports
#---------------------------------------

#district
udes      District Level Report
udate     May 99
uin       sashelp.class
uot       district
#district
;;;;
run;

****    ***   *   *   ***
*   *  *   *  ** **  *   *
*   *  *      * * *   *
****   * ***  *   *    *
*      *   *  *   *     *
*      *   *  *   *  *   *
*       ***   *   *   ***;

/* one program uses the config file and the other does not */
%macro region
       (
         udes   = Region level report,
         uobj   = region,
         udate  = June 96,
         uin    = sashelp.class,
         uot    = region,
         ucnf   = c:\temp\cnf.txt   /* config file             */
                                   /* "no" to turn off config */
        )/des ="Region Reports";
  /*----------------------------------------------*\
  |  utlprse parses the config file and overwrites |
  |  some or all of the macro arguments            |
  |  whatever is in the config file                |
  \*----------------------------------------------*/
      %put *** &ucnf ***;
      %if  %qupcase(&ucnf) ne NO %then %do;
            %utlprse
                (
                 ugetobj = &uobj,
                 ucnf    = &ucnf );
      %end;
      data class;
        set sashelp.class;
        if sex='M';
        dte="&udate";
        put dte=;
      run;
      /* date should be from config file not this macro */
      title "&udate &uobj &udes";
      proc print data=class;
      run;
%mend region;

%macro district
       (
         udes   = District level report,
         uobj   = district,
         udate  = June 96,
         uin    = sashelp.class,
         uot    = district,
         ucnf   = no
        )/des ="District Reports";
  /*----------------------------------------------*\
  |  utlprse parses the config file and overwrites |
  |  some or all of the macro arguments            |
  \*----------------------------------------------*/
      %put *** &ucnf ***;
      %if %qupcase(&ucnf) ne NO %then %do;
            %utlprse
                (
                 ugetobj = &uobj,
                 ucnf    = &ucnf );
      %end;
      data class;
        set sashelp.class;
        if sex='F';
        dte="&udate";
        put dte=;
      run;
      title "&udate &uobj &udes";
      proc print data=class;
      run;
%mend district;

/*
==============================================================
 The key arguments are uobj and ucnf. If ucnf is not equal to 'no'
 then some or all of the previous arguments are overwritten
 by config file values. The values are found in the
 'uobj' section of the config file.

 Note this structure is very flexible:

    1. You can set ucnf = no an the config file will not
       overwrite any  of the keyword arguments above.
    2. You can set up config file to overwrite some or all args.
    3. You can cut out the macro invocation and submit it under
       display manager.
*/

****   ****   *****  *   *  *****  ****
 *  *  *   *    *    *   *  *      *   *
 *  *  *   *    *    *   *  *      *   *
 *  *  ****     *    *   *  ****   ****
 *  *  * *      *    *   *  *      * *
 *  *  *  *     *     * *   *      *  *
****   *   *  *****    *    *****  *   *;

%utlmcro
       (
        unobj=2,

        uobj1=region,
        udes1=Region level Report,
        ustrx1=%str(region
                    (
                     udes   = Region report,
                     uobj   = region,
                     udate  = June 96,
                     uin    = sashelp.class,
                     uot    = region,
                     ucnf   = c:\temp\cnf.txt
                    )
                   ),


        udes2=District level Report,
        uobj2=district,
        ustrx2=%str(district
                    (
                     udes   = District report,
                     uobj   = district,
                     udate  = June 96,
                     uin    = sashelp.class,
                     uot    = district,
                     ucnf   = no
                    )
                   )
       );

dm "pmenu off";

