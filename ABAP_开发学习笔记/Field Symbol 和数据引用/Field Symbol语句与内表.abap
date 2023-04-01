*内表也可用于在变量赋值的过程中分配给field symbol 使用。
*可以省略复制到结构体的过程，提高性能。
















**---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.


DATA:BEGIN OF gs_line,
       col1(1) TYPE c,
       col2(1) TYPE c VALUE 'x',
     END OF gs_line.

FIELD-SYMBOLS:<sf> LIKE gs_line.
ASSIGN gs_line TO <sf>.

MOVE <sf>-col2 TO <sf>-col1.

WRITE:<sf>-col1,<sf>-col2.