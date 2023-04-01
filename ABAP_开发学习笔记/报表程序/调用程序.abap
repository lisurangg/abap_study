*1、调用报表程序
*TYPE-1程序可以用如下的SUBMIT语句调用
" SUBMIT <rep>|(<field>) [AND RETURN] [<options>].
*&-----------------------------------------*
*调用报表程序与SELECTION-SCREEN
*执行TYPE-1程序首先显示包含parameters和 select-option的标准selection-screen画面
*利用 submit语句可以执行想 selection-screen输入字段中填值的多种选项。
" SUBMIT...[VIA SELECTION-SCREEN]
"          [USING SELECTION-SET var]
"          [WITH p on f SIGN s]
"          [WITH FREE SELECTIONS freesel]
"          [WITH SELECTION-TABLE rspar]
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

TABLES:sflight.

DATA:gt_seltab TYPE TABLE OF rsparams WITH HEADER LINE.
DATA:gs_report(40) TYPE c.

gs_report = 'Z12_01'.

CLEAR gt_seltab.
gt_seltab-selname = 'SEL_carr'.
gt_seltab-kind    = 'S'.
gt_seltab-sign    = 'I'.
gt_seltab-option  = 'EQ'.
gt_seltab-low     = 'AA'.
APPEND gt_seltab.

SUBMIT (gs_report)
WITH SELECTION-TABLE gt_seltab AND RETURN.






*2、调用事务码
*若程序存在事务码，则可执行事务码调用其他程序。
" LEAVE TO TRANSACTION tcod [AND SKIP FIRST SCREEN].
*执行上面所示语句会在结束调用的程序的同时执行新程序。结束调用程序，则会回到刚执行时的初始菜单画面。
" CALL TRANSACTION tcod [AND SKIP FIRST SCREEN].
*此语句在保存被调用程序的数据的同时调用事务码。



