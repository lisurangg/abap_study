
*select 语句从数据库表中读取必要数据。
*select 语句分为两部分。一部分<lines>，用于指定查询数据件数（查询一句时用single）。
*<columns>用于指定要查询的数据库表字段。
*SEKECT<lines><columns>...
*一条数据   SELECT SINGLE<cols>...WHERE
*several line    SELECT[DISTINCT]<cols>...WHERE    DISTNCT语句用于删除重复值。
*!!!INTO  语句的结果不是保存到内表而是字段或者结构体时，最后要加ENDSELECT语句。相当于在LOOP循环中执行SELECT。
" 结构体需使用SELECT~ENDSELECT      内表一次保存所有值因此不存在 ENDSELECT.
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:gt_itab TYPE STANDARD TABLE OF sflight,
     gs_wa   TYPE sflight.

SELECT * INTO gs_wa FROM sflight WHERE carrid EQ 'AA'.

  WRITE:/ gs_wa-carrid,gs_wa-connid.

ENDSELECT.

*&---------------------------------------------------------------------*
DATA:gt_itab TYPE STANDARD TABLE OF sflight,
     gs_wa   TYPE sflight.

SELECT * INTO TABLE gt_itab FROM sflight WHERE carrid EQ 'AA'.

LOOP AT gt_itab INTO gs_wa.
  WRITE:/ gs_wa-carrid,gs_wa-connid.
ENDLOOP.



*AS( 别名 )
*利用 as语句可以给字段指定别名。
" select <cols> [as<alias>].

*动态 SELECT语句
*可以动态定义select语句的字段，保存动态语句结构体gs_line最多可以容纳72为char类型，结构体gs_line为null时与 * 语句相同。











types:begin of initial_type,
        group       type c length 1,
        number      type i,
        descrioyion type c length 3,
      end of initial_type.
data:initial_itab type standard table of initial_type,                "用data定义与此处的types定义内表有何不同?用原有的types：后续用append插入时报错。
     wa_initial type initial_type.                                     "定义wa_initial为initial_itab的工作区


wa_initial-group       = 'A' .
wa_initial-number      = '10'.                                        
wa_initial-descrioyion = 'A-2'.
append wa_initial to initial_itab.
clear wa_initial.


select*into wa_initial from initial_itab where carrid eq '10'.
wriet:wa_initial-carride.
endselect.


