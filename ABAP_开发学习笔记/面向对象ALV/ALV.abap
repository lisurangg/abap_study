*&---------------------------------------------------------------------*
*& Report Z15_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z15_01.

DATA: header(30),
      spfli_tab  TYPE SORTED TABLE OF spfli
                 WITH UNIQUE KEY cityfrom cityto carrid connid,
      spfli_line TYPE spfli.

*----------------------------------------------------------------------*
*Processing Block 1 : INITIALIZATION       事件块 INITIALIZATION  初始化程序
INITIALIZATION.
  header = 'Demo program for report event'.    "为表头赋值

*----------------------------------------------------------------------*
*Processing Block 2 : START-OF-SELECTION     事件块 START-OF-SELECTION
START-OF-SELECTION.
  SELECT * INTO CORRESPONDING FIELDS OF spfli_line FROM spfli.
    INSERT spfli_line INTO TABLE spfli_tab.
  ENDSELECT.

*----------------------------------------------------------------------*
*Processing Block 3 : END-OF-SELECTION
END-OF-SELECTION.
  LOOP AT spfli_tab INTO spfli_line.
    WRITE: / spfli_line-cityfrom,
             spfli_line-cityto,
             spfli_line-carrid,
             spfli_line-connid.
  ENDLOOP.

*----------------------------------------------------------------------*
*Processing Block 4 : TOP-OF-PAGE   
TOP-OF-PAGE.
  WRITE header.
  SKIP.

*查询中包含四个事件，开始运行后，运行环境将触发初始化，数据选择和列表输出，页眉输出等事件，
*该程序中没有定义选择屏幕，逻辑数据库以及与用户交互相关的事件，


*事件块的中止

*&---------------------------------------------------------------------*
*& Report Z15_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z15_01.

PARAMETER p_mede(5).    "定义屏幕

START-OF-SELECTION.     "开始事件块
  CASE p_mede.          "判断 p_mede
    WHEN 'STOP'.     
      WRITE / 'Testing STOP'.
      STOP.
    WHEN 'EXIT'.
      WRITE / 'Testing EXIT'.
    WHEN OTHERS.
      CHECK p_mede = 'CHECK'.
      WRITE / 'Testing CHECK'.
  ENDCASE.
  WRITE / 'End of START-OF-SELECTION'.

END-OF-SELECTION.
  WRITE / 'End of Report'.
*STOP
" Testing STOP
" End of report
*在开始事件中由于STOP语句作用，系统直接运行END-OF-SELECTION事件块，不执行当前事件块后续的语句

*EXIT
" Testing EXIT
*执行到EXIT语句后，系统直接进行报表输出，而不是运行END-OF-SELECTION语句块

*CHECK
" Testing CHECK
" End of START-OF-SELECTION
" End of report

*OTHER
" Testing CHECK
" End of report
*系统离开START-OF-SELECTION块，并转向下一事件，此处为END-OF-SELECTION