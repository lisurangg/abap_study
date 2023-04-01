
*可利用describe 语句来确定内表属性。
*describe table itab [lines gv_line][occurs gv_init][kind gv_kind].
*lines返回内表包含数据件数，occurs返回内表的初始大小。kind返回内表类型，t代表标准表 s排序 h哈希。

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:BEGIN OF gs_line,
       col1 TYPE c,
       col2 TYPE i,
     END OF gs_line.

DATA gt_itab LIKE STANDARD TABLE OF gs_line INITIAL SIZE 10.

DATA gv_line TYPE i.
DATA gv_init TYPE i.

DO 20 TIMES.
  gs_line-col1 = sy-index.
  gs_line-col2 = sy-index.
  INSERT gs_line INTO TABLE gt_itab.
ENDDO.

DESCRIBE TABLE gt_itab LINES gv_line OCCURS gv_init.
WRITE:/ 'intermal table line is:',gv_line,/ 'initermal table occurs is:',gv_init.

"输出结果为：intermal table line is:20.    initermal table occurs is:10.