*1、INITIALIZATION
*在时间执行程序时最先执行的是 INITIALIZATION.此事件在显示SELECTION-SCREEN之前触发，
*因此一般用于指定变量初始值，
*即在INITIALIZATION事件中指定SELECTION-SCREEN中使用的字段初始值，自动输入用户经常使用的值。

" INITIALIZATION.
" p_1 = 'AA'.

*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

TABLES:sflight.

PARAMETERS:p_carrid LIKE sflight-carrid,
           p_connid LIKE sflight-connid.

SELECT-OPTIONS:s_fldate FOR sflight-fldate.

initialization.                           "删除或隐藏此语句则没有初始值。
* SET TITLEBAR 'T1000'.
* SET PF-STATUS 'TEST'.

p_carrid = 'AA'.
p_connid = '17'.

s_fldate-low  = '20220101'.
s_fldate-high = '20221231'.
APPEND s_fldate.



*2、AT SELECTION-SCREEN
" AT SELECTION-SCREEN是在 SELECTION-SCREEN中Input Field的值有变更时执行的事件。
" INITIALIZATION 与 START-OF-SELECTION之间被触发，且对事件有回应并调节画面字段。





*START-OF-SELECTION
*若已经结束查询画面上字段的初始值设置及数据检查，就要执行从数据库读取数据的实质性操作。
*执行sql语句之前最好先执行CLEAR语句等准备操作后执行SELECT语句。
" START-OF-SELECTION.
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:g_total TYPE i,
     g_cent  TYPE i,
     g_index TYPE i.

DATA gt_sflight TYPE TABLE OF sflight WITH HEADER LINE.

START-OF-SELECTION.
  SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_sflight FROM sflight.

  DESCRIBE TABLE gt_sflight LINES g_total.

  LOOP AT gt_sflight.
    g_cent = g_cent = 1.
    PERFORM progress_indicator USING g_cent g_total 'progressing'.
  ENDLOOP.

  WRITE 'success'.

FORM progress_indicator USING VALUE(p_cur) VALUE(p_total) VALUE(p_text).

  DATA:lv_text(50) TYPE c,
       lv_idx(3)   TYPE n.

  lv_idx = ( p_cur / p_total ) * 100.

  CONCATENATE lv_idx '%:' p_text INTO lv_text.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
      percentage = lv_idx
      text       = lv_text
    EXCEPTIONS
      OTHERS     = 0.

ENDFORM.





*END-OF-SELECTION
*此事件作为执行环境下最后调用的事件，是在查询所有数据后最终将这些数据输出到画面之前执行。
*即在SELECT语句中读取所有数据后，画面中显示write在此事件内可以做修改内表数据的操作。
" END-OF-SELECTION
" 是从START-OF-SELECTION中读取数据后在END-OF-SELECTION中显示数据到画面的实例。
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

DATA:gs_str  TYPE scarr,
     gt_itab TYPE TABLE OF scarr.

START-OF-SELECTION.
  SELECT *
  INTO CORRESPONDING FIELDS OF TABLE gt_itab
  FROM scarr.

END-OF-SELECTION.
  LOOP AT gt_itab INTO gs_str.
    WRITE:/ gs_str-carrid,gs_str-carrname.
  ENDLOOP.