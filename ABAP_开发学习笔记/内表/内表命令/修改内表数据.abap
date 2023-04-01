*利用表关键字或索引可以修改相应行数据。
*利用以下语句以关键字为基准修改内表行数据。内表关键字并非唯一，存在重复数据时执行modify会修改第一条数据。
" modify table itab from wa [transporting f1 f2..]
" 可利用transporting语句修改指定字段的值。

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:BEGIN OF gs_line,
       col1(2) TYPE c,
       col2    TYPE i,
       col3    TYPE sy-datum,
     END OF gs_line.

DATA gt_itab LIKE STANDARD TABLE OF gs_line WITH NON-UNIQUE KEY col1 col2.     "unique指定内表的关键字字段的值的唯一性，non-unique指定内表的关键字字段的值可以出现重复性。

gs_line-col1 = 'aa'.
gs_line-col2 = '50'.
INSERT gs_line INTO TABLE gt_itab.

gs_line-col1 = 'aa'.
gs_line-col2 = '26'.
INSERT gs_line INTO TABLE gt_itab.

gs_line-col1 = 'aa'.
gs_line-col2 = '50'.
gs_line-col3 = '20230313'.
MODIFY TABLE gt_itab FROM gs_line.

LOOP AT gt_itab INTO gs_line.
  WRITE:/ gs_line-col1,gs_line-col2,gs_line-col3.
ENDLOOP.

*输出值：aa   50   2023.03.13      /aa   26   0000.00.00




*修改一条以上的数据时使用 where语句。
" modify itab from wa transporting f1 f2 ... where cond.
DATA:BEGIN OF gs_line,
       col1 TYPE sflight-carrid,
       col2 TYPE sflight-fldate,
     END OF gs_line.

DATA gt_itab LIKE TABLE OF gs_line.

SELECT carrid connid INTO CORRESPONDING FIELDS OF TABLE gt_itab FROM sflight.

LOOP AT gt_itab INTO gs_line.

  AT NEW carrid.

    SELECT SINGLE carrname INTO gs_line-carname FROM scarr WHERE carrid = gs_line-carrid.

    MODIFY gt_itab FROM gs_line INDEX sy-tabix TRANSPORTING carname.
  ENDAT.
  WRITE:/ gs_line-carrid,gs_line-carname.

ENDLOOP.








*利用索引可以修改对应行的值，因为使用索引，所以只能用于排序表与标准表。在loop语句中可以省略index选项，此时会修改当前索引行数据。
" MODIFY itab FROM wa [INDEX idx] [TRANSPORTING f1 f2...].
data:begin of gs_line,
   carrid type sflight-carrid,
   connid type sflight-connid,
   fldate type sflight-fldate,
     end of gs_line.

data gt_itab like table of gs_line.

select carrid connid into COMPARING fields of table gt_itab from sflight.

loop at gt_itab into gs_line.

  select single carrname into gs_line-carrname from scarr where carrid = gs_line-carrid.

  modify gt_itab from gs_line.

  write:/ gs_line-carrid,gs_line-carrname.

endloop.