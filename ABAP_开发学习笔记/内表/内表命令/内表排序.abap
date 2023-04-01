
*1 SORT 用此语句可以排序标准表及哈希表默认排序方式为ascending。排序表自生数据是已排好的，再使用sort会产生sytax error。
*sort itab [ascending|desceding].
" sort itab by f1 [ascending|desceding] f2 [ascending|desceding].

*stable sort 每次使用sort命令时排序序列号一直在变。使用stable sort语句就能保留排序序列号，但是也存在小号更多排序时间的弊端。
" sort itab... stable.
" 相同数的前后顺序以及序列号。

" 5'1'   4'2'   3'3'   5'4'   2'5'
" 2'5'   3'3'   4'2'   5'1'   5'4'

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

DATA:gt_itab LIKE STANDARD TABLE OF gs_line.

gs_line-col1 = 'b'.
gs_line-col2 = 3.
APPEND gs_line TO gt_itab.

gs_line-col1 = 'c'.
gs_line-col2 = 4.
APPEND gs_line TO gt_itab.

gs_line-col1 = 'a'.
gs_line-col2 = 1.
APPEND gs_line TO gt_itab.

gs_line-col1 = 'a'.
gs_line-col2 =  2.
APPEND gs_line TO gt_itab.

SORT gt_itab BY col1 DESCENDING col2 ASCENDING.
PERFORM write_data.

FORM write_data.
  LOOP AT gt_itab INTO gs_line.
    WRITE:/ gs_line-col1,gs_line-col2.
  ENDLOOP.
  ULINE.
ENDFORM.