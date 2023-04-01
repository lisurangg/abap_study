
*内表与其他变量一样，也可以用move语句进行赋值。
*move itab to itab2.
*需要两个内表类型一致，当两表类型不同时，可以使用 move-corresponding itab1 to itab2.

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

types:begin of t_line,
   col1 type i,
   col2 type i,
      end of t_line.

data:gt_itab1    type standard table of t_line,
     gt_itab2    type standard table of t_line,
     gs_wa_itab1 type t_line,
     gs_wa_itab2 like line of gt_itab2.

do 5 times.
    gs_wa_itab1-col1 = sy-index.
    gs_wa_itab1-col2 = sy-index * 2.
    insert gs_wa_itab1 into table gt_itab1.        "此处也可用 append gt_wa_itab1 to gt_itab1.
enddo.                                             "APPEND 结构体 TO 表名. (向内表的最后一行插入一行，APPEND只能用于标准表中).   
move gt_itab1 to gt_itab2.                        

loop at gt_itab2 into gs_wa_itab2.
    write:/ gs_wa_itab2-col1,gs_wa_itab2-col2.
endloop.




*内表初始化
*clear语句返回（release）内存空间。但不删除刚开始要求的内存容量信息。
*clear itab。
" clear删除内表数据的同时释放了内存空间。
" refresh语句只删除内表数据，无法删除内存空间，有必要使用free语句释放内存
" refresh itab.
" free itab.

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

data:begin of gs_line,
   col1 type i,
   col2 type c,
     end of gs_line.

data:gt_itab like standard table of gs_line.
gs_line-col1 = 1.
gs_line-col2 = 2.
insert gs_line into table gt_itab.

refresh gt_itab.             "三种方法都已清楚数据
*free  gt_itab.
*clear gt_itab.

if gt_itab is initial.
    write:'internal Table have no data'.
    free gt_itab.
endif.