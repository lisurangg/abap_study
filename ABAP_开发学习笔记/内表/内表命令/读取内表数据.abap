*利用关键字可以读取内表数据，result是储存read结果的工作区。
" READ TABLE itab FROM wa INTO result.
" READ TABLE itab WITH TABLE KEY k1 = f1.kn = fn INTO result.使用此语句不能多次使用相同字段。
*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:BEGIN OF gs_line,
       carrid   TYPE scarr-carrid,
       carrname TYPE scarr-carrname,
     END OF gs_line.

DATA gt_line LIKE TABLE OF gs_line WITH NON-UNIQUE KEY carrid.

SELECT carrid carrname INTO CORRESPONDING FIELDS OF TABLE gt_line FROM scarr.

gs_line-carrid = 'AA'.
READ TABLE gt_line FROM gs_line INTO gs_line.
WRITE:/ gs_line-carrid,gs_line-carrname.
CLEAR:gs_line.

READ TABLE gt_line WITH TABLE KEY carrid = 'AB' INTO gs_line.
WRITE: / gs_line-carrid,gs_line-carrname.





*利用索引可以读取相应行的数据。
*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:BEGIN OF gs_line,
       col1 TYPE c,
       col2 TYPE c LENGTH 7,
     END OF gs_line.

DATA gt_line LIKE SORTED TABLE OF gs_line WITH UNIQUE KEY col1.

gs_line-col1 = 'a'.gs_line-col2 = 'frist'.
INSERT gs_line INTO TABLE gt_line.
CLEAR gs_line.

gs_line-col1 = 'b'.gs_line-col2 = 'second'.
INSERT gs_line INTO TABLE gt_line.
CLEAR gs_line.

READ TABLE gt_line INTO gs_line INDEX 1.

WRITE:/ 'col1 is',gs_line-col1,'col2 is',gs_line-col2.


*如果只想检查相关记录是否存在，并且不必使用该记录的值，则可以使用“transporting no fields”技术

read table temp_data transporting no fields with key number = 6.
if sy-subrc = 0.                        "判断是否读取到了数据，0为读取到至少一条数据，4为未读取到数据，9为系统错误。
  result_index = sy-tabix.
endif.