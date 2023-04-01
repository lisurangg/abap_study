
*插入内表行的数据有 insert、append、collect这三种。insert和append都是将数据插到内表最后一行，
*但insert语句根据内表类型不同，其执行结果也有所不同。collect语句用于合计关键字相同的数字类型的字段，关键字不同的直接追加数据。



" 利用表关键字追加一条数据时，可以利用如下语句，即利用关键字向内表追加一条数据，
" insert line into itab.
" 可以利用insert语句追加多条数据，但itab1与itab2表类型要相同。
" insert lines of itab1 [form n1][to n2] into table itab2.

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:BEGIN OF gs_line,                               "data与types的不同之处，data定义的结构直接算是内表的工作区，且两个表之间可以互通，而types的话，需重新定义一个工作区。
       col1 TYPE c,
       col2 TYPE i,
     END OF gs_line.

DATA gt_itab1 LIKE STANDARD TABLE OF gs_line.
DATA gt_itab2 LIKE TABLE OF gs_line.

gs_line-col1 = 'b'.
gs_line-col2 = '1'.
INSERT gs_line INTO TABLE gt_itab1.

gs_line-col1 = 'a'.
gs_line-col2 = '2'.
INSERT gs_line INTO TABLE gt_itab1.

gs_line-col1 = 'c'.
gs_line-col2 = '3'.
INSERT gs_line INTO TABLE gt_itab1.

INSERT LINES  OF gt_itab1 INTO TABLE gt_itab2.

LOOP AT gt_itab2 INTO gs_line.
  WRITE:/ gs_line-col1,gs_line-col2.
ENDLOOP.




" 此处用types的话。会很麻烦
*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

TYPES:BEGIN OF gs_line,
        col1 TYPE c,
        col2 TYPE i,
      END OF gs_line.

DATA gt_itab1 TYPE STANDARD TABLE OF gs_line.
DATA gt_itab2 TYPE TABLE OF gs_line.
DATA ls_line  LIKE LINE OF gt_itab1.
DATA ls_line2 LIKE LINE OF gt_itab2.

ls_line-col1 = 'b'.
ls_line-col2 = '1'.
INSERT ls_line INTO TABLE gt_itab1.

ls_line-col1 = 'a'.
ls_line-col2 = '2'.
INSERT ls_line INTO TABLE gt_itab1.

ls_line-col1 = 'c'.
ls_line-col2 = '3'.
INSERT ls_line INTO TABLE gt_itab1.

INSERT LINES  OF gt_itab1 INTO TABLE gt_itab2.

LOOP AT gt_itab2 INTO ls_line2.
  WRITE:/ ls_line2-col1,ls_line2-col2.
ENDLOOP.




*insert 语句可以利用关键字及索引追加数据，但是append语句只能利用索引。即哈希表不能使用此语句。
" 追加一条数据
" append line to itab.
" 追加多条数据
" append lines of itab1 to itab2.
" 在标准表中将数据追加到最后一行
" 在排序表中按照安排好的顺序追加数据。
" 使用 sorted by语句会自动以字段f为基准降序排序后追加数据，只适用标准表，还需用initial size语句指定大小。
" append wa to itab sorted by f.

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:BEGIN OF gs_line,
       col1 TYPE c,
       col2 TYPE n,
     END OF gs_line.

DATA gt_itab LIKE STANDARD TABLE OF gs_line.

gs_line-col1 = 'b'.
gs_line-col2 = '1'.
APPEND gs_line TO gt_itab.

gs_line-col1 = 'a'.
gs_line-col2 = '2'.
APPEND gs_line TO gt_itab.

gs_line-col1 = 'c'.
gs_line-col2 = '3'.
APPEND gs_line TO gt_itab.





*使用collect语句可以合计内表中数字类型字段。
" collect wa into itab
" 除关键字以外的数据都需要是数字类型（f、i、p、）。
" 执行collect语句，当存在相同关键字数据时，合计数字类型字段，不存在相同关键字的数据，直接追加数据。

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:BEGIN OF gs_line,
       col1(3) TYPE c,
       col2(2) TYPE n,
       col3    TYPE i,
     END OF gs_line.

DATA gt_itab LIKE STANDARD TABLE OF gs_line.

gs_line-col1 = 'aa'.gs_line-col2 = '17'.gs_line-col3 = '660'.
COLLECT gs_line INTO gt_itab.

gs_line-col1 = 'al'.gs_line-col2 = '34'.gs_line-col3 = '220'.
COLLECT gs_line INTO gt_itab.

gs_line-col1 = 'aa'.gs_line-col2 = '17'.gs_line-col3 = '280'.
COLLECT gs_line INTO gt_itab.

LOOP AT gt_itab INTO gs_line.
  WRITE:/ gs_line-col1,gs_line-col2,gs_line-col3.
ENDLOOP.

" 输出结果为 aa 17 940\   al 34 220.