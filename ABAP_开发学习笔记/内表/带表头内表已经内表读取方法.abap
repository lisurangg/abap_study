*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*此处使用的是带表头的内表，定义方式为data:1_itab type table of 结构 with header line.
*带表头的内表不建议使用，表头相当于一个内表的同名工作区，且想使用此内表时不能直接1_itab，如此系统会识别为1_itab的工作区，如想表达内表则要在1_itab后加[],如1_itab[].
*访问内表的方法有loop at <itable> to <wa>.此处wa为itable的工作区。
*定义工作区的方法：data wa_itab type 结构.


REPORT ZDEMO.


types:begin of initial_data,                                                 "定义一个结构。
        group       type c length 1,          
        number      type i,
        descrioyion type string,
      end of initial_data.
data: initial_type TYPE TABLE OF initial_data WITH HEADER LINE.               "定义一个有表头的内表。


initial_type-group       = 'A' .
initial_type-number      = '10'.
initial_type-descrioyion = 'A-2'.
append initial_type.
clear initial_type.
initial_type-group       = 'B'.
initial_type-number      = '5'.
initial_type-descrioyion = 'B'.
append initial_type.
clear initial_type.
initial_type-group       = 'A'.
initial_type-number      = '6'.
initial_type-descrioyion = 'A-1'.
append initial_type.
clear initial_type.
initial_type-group       = 'c'.
initial_type-number      = '22'.
initial_type-descrioyion = 'C-1'.
append initial_type.
clear initial_type.







loop at initial_type.
    write:initial_type-group,initial_type-number,initial_type-descrioyion,/.        "循环输出，输出完整主要靠最后的'/'。
    endloop.