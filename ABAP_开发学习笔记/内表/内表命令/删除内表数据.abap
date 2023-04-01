*利用表关键字删除一条数据。
*以关键字为基准删除内表一条数据，在关键字不唯一一点标准表中使用with table key语句删除重复数据中的一条数据
" DELETE TABLE itab [FROM wa].
" DELETE TABLE itab WITH TABLE KEY k1 = f1...kn = fn.

*利用WHERE条件删除多条数据
" DELETE itab WHERE cond.
*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:BEGIN OF gs_line,
       carrid TYPE sflight-carrid,
       connid TYPE sflight-connid,
     END OF gs_line.

DATA gt_line LIKE TABLE OF gs_line WITH NON-UNIQUE KEY carrid.

SELECT carrid connid INTO CORRESPONDING FIELDS OF TABLE gt_line FROM sflight.

DELETE gt_line WHERE carrid = 'AA' AND connid = '0017'.

LOOP AT gt_line INTO gs_line.
  WRITE:/ gs_line-carrid,gs_line-connid.
ENDLOOP.






*利用索引删除内表数据
" DELETe itab [INDEX idx].
*利用索引也可一次删除多条数据，在哈希表中无法使用，
*使用FROM n1 语句会删除n1后面的所有数据，使用 TO n2 语句，会删除从开始到 n2之间的所有数据。
data:begin of gs_line,
   col1 type i,
   col2 type i,
     end of gs_line.

data gt_line like table of gs_line.

do 3 times.
    gs_line-col1 = sy-index.
    gs_line-col2 = sy-index * 2.
enddo.

delete gt_line index 2.

loop at gt_line into gs_line.
    write:/ gs_line-col1,gs_line-col2.
endloop.

" 删除了第二行数据。




*利用ADJCENT DUPLICATE语句可以删除重复行，执行此语句先要用SORT语句排序内表。
" DELETE ADJCENT DUPLICATE ENNTRIES FROM itab [COMPARING f1 f2...|ALL FIELDS].
*不使用COMPARING语句会删除关键重复的数据，在没有定义关键字的情况下，前几个字符串类型的字段将会成为关键字。

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:BEGIN OF gs_line,
       carrid TYPE sflight-carrid,
       connid TYPE sflight-connid,
     END OF gs_line.

DATA gt_line LIKE TABLE OF gs_line.

SELECT carrid connid INTO CORRESPONDING FIELDS OF TABLE gt_line FROM sflight.
DELETE ADJACENT DUPLICATES  FROM gt_line.

LOOP AT gt_line INTO gs_line.
  WRITE:/ gs_line-carrid,gs_line-connid.
ENDLOOP.