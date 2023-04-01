*程序结构--List Process事件
*1、TOP-OF-PAGE(页眉）
*TOP-OF-PAGE 在新一页输出第一行数据之前执行，另外，在使用NO STANARD PAGE HEADING 选择的程序中直接输入报表表头时使用。
" TOP-OF-PAGE
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

TOP-OF-PAGE.
  WRITE:sy-title,60'page no',sy-pagno.
  ULINE.
  WRITE:/ 'enjoy abap',sy-datum.

START-OF-SELECTION.
  DO 50 TIMES.
    WRITE / sy-index.
  ENDDO.





*2、END-OF-PAGE(页尾）
*END-OF-PAGE是当前页页脚触发事件。、
*若明确指定Line-count，则当前页行数超过Line-count时即可执行。
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo LINE-SIZE 60 LINE-COUNT 10(2).
*LINE-SIZE为行宽度， LINE-COUNT为行数。
TOP-OF-PAGE.
  WRITE:'top of page'.
  ULINE AT /(60).

END-OF-PAGE.
  ULINE.
  WRITE:/30'page no',sy-pagno.


START-OF-SELECTION.
  DO 50 TIMES.
    WRITE / sy-index.
  ENDDO.





*3、AT LINE-SELECTION.<谱线择定，选行>
*当双击报表的一行或按<F2>时触发的事件。此时发生的 SY-UCOMM系统变量中被分配'PICK'值。
*如实例所示可以指定颜色即 INVERS。若以 ON语句开始，则一定要以 OFF语句结束。
" AL LINE-SELECTION.
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo LINE-SIZE 60 LINE-COUNT 10(2).

START-OF-SELECTION.
  WRITE 'First List'.

  FORMAT HOTSPOT ON COLOR 4.
  WRITE:/ 'Clik this line'.
  FORMAT HOTSPOT OFF COLOR OFF.

AT LINE-SELECTION.
  WRITE:'secend list'.
  WRITE:/ 'sy-ucomm =',sy-ucomm.



*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:gs_scarr    TYPE scarr,
     gt_scarr    TYPE TABLE OF scarr,
     gv_fname    TYPE c,
     gv_value    TYPE c,
     gv_carrid   LIKE scarr-carrid,
     gv_carrname LIKE scarr-carrname.

AT LINE-SELECTION.
  GET CURSOR FIELD gv_fname VALUE gv_value.             "，在当前光标所在的行，获取名为 gv_fname 的字段的值，并将其存储在变量 gv_value 中。它用于在屏幕模式下选择一行并提取该行的值。

  CASE gv_fname.                                           "比较gv_fname的值
    WHEN 'gs_scarr-carrid'.                                "如果等于gs_scarr-carrid时
      SPLIT sy-lisel AT ' ' INTO gv_carrid gv_carrname.     "将sy-lisel按照空格分隔为 gv_carrid和 gv_carrname，并将他们写入输出。
      WRITE:gv_carrid,gv_carrname.

    WHEN OTHERS.
  ENDCASE.

START-OF-SELECTION.
  SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_scarr FROM scarr.

  LOOP AT gt_scarr INTO gs_scarr.
    WRITE:/ gs_scarr-carrid,gs_scarr-carrname.
  ENDLOOP.





*4、AT USER-COMMAND(用户推荐)
*在程序执行用 Function定义的功能。
start-of-selection.
set pf-status 'test'.
write:'Click the button'.

at user-command.
case sy-ucomm.
    when 'FC1'.
    leave program.
endcase.





*5、TOP-OF-PAGE DURING LINE-SELECTION
*在次级报表中控制表头时使用的事件。系统变量sy-lsind中含有现在报表索引。
*每当显示次级报表（secondary list）会加1.
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

TOP-OF-PAGE.                             "设置第一级报表表头
  WRITE:'First List TOP-OF-PAGE'.
  ULINE.        "框线，底线。

TOP-OF-PAGE DURING LINE-SELECTION.      "设置第二级报表
  WRITE 'Secondary list TOP-OF-PAGE'.
  ULINE.

AT LINE-SELECTION.
  PERFORM write_list.                  "此处调用子程序 write_list

START-OF-SELECTION.
  WRITE:'Double-click this line'.

FORM write_list.
  WRITE:'Secondary List',/'sy-pfkey','sy-pfkey'."此处定义第二级报表内容
ENDFORM.