*---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.


*结构体类型gs_human是包含结构体类型gs_man的嵌套结构体类型。
TYPES:BEGIN OF gs_man,
  name    TYPE c LENGTH 5,
  country TYPE c LENGTH 10,
  city    TYPE string,
      END OF gs_man.


*定义嵌套结构体。
TYPES BEGIN OF gs_human.
  INCLUDE TYPE gs_man.
TYPES:phone TYPE c LENGTH 10,
  END OF gs_human.


DATA wa_people TYPE gs_human.


wa_people-name = '李'.
wa_people-country = 'CHINA'.
wa_people-city    = '长沙'.
wa_people-phone   = '1103446717'.


WRITE:/ wa_people-name,wa_people-country,wa_people-city,wa_people-phone.






