
*&---------------------------------------------------------------------*
*& Report ZTEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTEST.


PERFORM write.                                                               "创建新程序以后输入perform write。为了生产子程序双击write语句。
*&---------------------------------------------------------------------*
*& Form WRITE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM write.                                                                  "在form和endform中追加代码就完成了一个子程序。
write'subroutine test'.
ENDFORM.