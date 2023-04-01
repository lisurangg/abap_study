*二分法是利用二进制式检索数据的方法，使用此方法前，首先要按照关键字（字段）排序内表数据。
*排序表已经按照关键字进行排序，因此不能使用sort命令，且默认包含了（binary search）的功能，无需再加此语句。
*且排序表比使用了binary search的标准表速度快。
" 标准表未使用二分法查找
*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

TYPES:BEGIN OF line,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE i,
      END OF line.

DATA:itab    TYPE STANDARD TABLE OF line WITH KEY col1,
     wa_itab TYPE line.

DO 10000000 TIMES.
  wa_itab-col1 = sy-index.
  wa_itab-col2 = sy-index.
  wa_itab-col3 = sy-index.
  INSERT wa_itab INTO TABLE itab.
ENDDO.

SORT itab BY col1 col2 col3 ASCENDING.
READ TABLE itab INTO wa_itab WITH KEY col1 = 5000 col2 = 100 col3 = 999999.




" 标准表使用二分法查找(BINARY SEARCH）

*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

TYPES:BEGIN OF line,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE i,
      END OF line.

DATA:itab    TYPE STANDARD TABLE OF line WITH KEY col1,
     wa_itab TYPE line.

DO 10000000 TIMES.
  wa_itab-col1 = sy-index.
  wa_itab-col2 = sy-index.
  wa_itab-col3 = sy-index.
  INSERT wa_itab INTO TABLE itab.
ENDDO.

SORT itab BY col1 col2 col3 ASCENDING.
READ TABLE itab INTO wa_itab WITH KEY col1 = 5000 col2 = 100 col3 = 999999 BINARY SEARCH.
