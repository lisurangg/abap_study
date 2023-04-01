
*FIeld Symbol的定义。
*FIELD-SYMBOLs<fs>[TYPE].
*Field Symbol 的变量用尖括号定义。


*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.


DATA:BEGIN OF gs_str,
       col1(1) TYPE c,
       col2    TYPE i,
     END OF gs_str.                                 "定义一个结构

DATA gt_str LIKE TABLE OF gs_str.

gs_str-col1 = 'a'.                                   "给结构赋值
gs_str-col2 = '1'.


FIELD-SYMBOLS:<sf1> LIKE gs_str,                      "定义两个FIELD-SYMBOLS    此处也可以用type any table，来定义表。
              <sf2> TYPE any.

ASSIGN gs_str TO <sf1>.                                "将结构字段分配到FIELD-SYMBOLS中

<sf1>-col1 = 'b'.                                      "对第一个FIELD-SYMBOL修改值
<sf1>-col2 = '2'.

DO 2 TIMES.                                            "循环两次
  ASSIGN COMPONENT sy-index OF STRUCTURE <sf1> TO <sf2>.  "这里应该是将<sf1>的值分配到<sf2>中 此语句不知道是否为固定。
  WRITE <sf2>.
ENDDO.




*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.


DATA:col_1 TYPE c VALUE 'a',
     col_2 TYPE c VALUE 'b',
     col_3 TYPE c VALUE 'c',
     col_4 TYPE c VALUE 'd',
     col_5 TYPE c VALUE 'e'.

DATA:fname TYPE c LENGTH 10.
DATA:idx   TYPE n.

FIELD-SYMBOLS:<fs>.

fname = col_1.

DO 5 TIMES.
  CLEAR:fname.
  fname = 'col_'.
  idx   = sy-index.
  CONCATENATE fname idx INTO fname.

  ASSIGN (fname) TO <fs>.                   "此处括号非常重要，没有括号就不会输出idx的值。
  WRITE:/ fname,<fs>.
ENDDO.





*结构体字段分配到 Field Symbol中。
*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.


DATA:BEGIN OF gs_str,
       col1 TYPE char5  VALUE 'china',
       col2 TYPE char10 VALUE 'beijing',
       col3 TYPE char15 VALUE 'twin building',
     END OF gs_str.

FIELD-SYMBOLS:<sf1> LIKE gs_str,
              <sf2> TYPE any.


ASSIGN gs_str TO <sf1>.

DO 3 TIMES.                                             "do 3 times是因为gs_str结构体字段有三个，通过储存 loop次数的系统变量 sy-index，将结构体字段一次分配到给FIELD-SYMBOL。
  ASSIGN COMPONENT sy-index OF STRUCTURE <sf1> TO <sf2>.
  WRITE <sf2>.
ENDDO.


*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.


DATA:BEGIN OF gs_str,
       col1 TYPE char5  VALUE 'china',
       col2 TYPE char10 VALUE 'beijing',
       col3 TYPE char15 VALUE 'twin building',
     END OF gs_str.

DATA:gv_fname TYPE c LENGTH 10,
     gv_idx   TYPE n.

FIELD-SYMBOLS:<sf1> LIKE gs_str,
              <sf2> TYPE any.

ASSIGN gs_str TO <sf1>.

DO 3 TIMES.
  CLEAR gv_fname.
  gv_idx = sy-index.
  gv_fname = 'col'.
  CONCATENATE gv_fname gv_idx INTO gv_fname.

  ASSIGN COMPONENT gv_fname OF STRUCTURE <sf1> TO <sf2>.
  WRITE:/ gv_fname,<sf2>.
ENDDO.

