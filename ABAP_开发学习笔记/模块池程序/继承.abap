*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

*-----------------------------------------------------------------------*
*class definition
*-----------------------------------------------------------------------*
CLASS vechicle DEFINITION INHERITING FROM object.    "创建基类
  PUBLIC SECTION.
    METHODS: accelerate, write_status.                "声明基类方法
  PROTECTED SECTION.
    DATA speed TYPE i.        "声明属性speed
ENDCLASS.

CLASS plane DEFINITION INHERITING FROM vechicle.      "创建派生类plane
  PUBLIC SECTION.
    METHODS: rise, write_status REDEFINITION.         "声明派生类方 rise并重载基类方法write_status
  PROTECTED SECTION.
    DATA altitude TYPE i.       "声明属性altitude
ENDCLASS.

CLASS ship DEFINITION INHERITING FROM vechicle.       "创建派生类ship
  PUBLIC SECTION.
    METHODS write_status REDEFINITION.                "重载基类方法write_status
ENDCLASS.


*-----------------------------------------------------------------------*
*class implementation
*-----------------------------------------------------------------------*
CLASS vechicle IMPLEMENTATION.         "定义基类
  METHOD accelerate.       "定义基类accelerate方法
    speed = speed + 1.
  ENDMETHOD.
  METHOD write_status.     "定义基类write_status方法
    WRITE:/ 'Speed: ', speed.
  ENDMETHOD.
ENDCLASS.

CLASS plane IMPLEMENTATION.             "定义派生类 plane
  METHOD rise.              "定义派生类 rise方法
    altitude = altitude + 1.
  ENDMETHOD. 
  METHOD write_status.      "定义派生类 write_status方法
    WRITE: / 'Plane: '.
    CALL METHOD super->write_status.   "在派生类方法中调用基类方法write_status（使用super关键字）
    WRITE: / 'Ship speed: ', altitude.
  ENDMETHOD.
ENDCLASS.

CLASS ship IMPLEMENTATION.                 "定义派生类 ship
  METHOD write_status.       "定义派生类 write_status方法
    WRITE: / 'Altitude: ', speed.
  ENDMETHOD.
ENDCLASS.

DATA: plane_ref TYPE REF TO plane,
      ship_ref  TYPE REF TO ship.

*-----------------------------------------------------------------------*
*start-of-selection
*-----------------------------------------------------------------------*
START-OF-SELECTION.
  CREATE OBJECT: plane_ref,ship_ref.
  CALL METHOD: plane_ref->accelerate,  "speed = speed + 1 =1   因为此处是在派生类plane中调用基类vehicle中的方法write_status，所以不是plane_speed而是speed
               plane_ref->rise,    "altitude = alititude + 1 =1
               plane_ref->write_status,    "write:speed = 1,write:altitued = 1
               ship_ref->accelerate,      "ship_speed = ship_speed + 1 = 1
               ship_ref->write_status.     "write:ship_speed = 1
*在该程序中，类ship和plane对基类vehicle中定义的方法accelerate进行重载，根据引用变量所参照的类，相同的方法在不同类的实现方法