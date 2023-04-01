*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.







*move-coresponding赋值，将gs_man结构里面在gs_info里有相同的结构的值复制到结构gs_info中,如果同一个字段在gs_info中也有值的话则会覆盖掉在gs_info中的值。
*定义结构体，如果如下直接赋值的话，必须得用data不能用types。
DATA:BEGIN OF gs_man,
       man(20)     VALUE 'Kim Sung Joon',
       country(10) VALUE 'China',
       city(20)    VALUE 'BeiJIng',
     END OF gs_man.



DATA:BEGIN OF gs_info,
       man(20) VALUE 'Li Qiang',
       city(10),
       phone(10) VALUE '1103446717',
     END OF gs_info.


MOVE-CORRESPONDING gs_man TO gs_info.
WRITE:/ gs_info-man,gs_info-city,gs_info-phone.