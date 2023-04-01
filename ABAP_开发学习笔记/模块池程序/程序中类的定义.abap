

*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

CLASS c1 DEFINITION.
  PUBLIC SECTION.
    METHODS meth.
ENDCLASS.            "C1 definition.

CLASS c1 IMPLEMENTATION.
  METHOD meth.
    WRITE / 'class test'.
  ENDMETHOD.
ENDCLASS.


DATA:go_cref TYPE REF TO c1.

START-OF-SELECTION.
  CREATE OBJECT go_cref.
  CALL METHOD go_cref->meth.

*这段 ABAP 代码定义了一个类 c1，其中有一个公共方法 meth。在实现部分，定义了 meth 方法写入了一条输出信息。
*在主程序部分，定义了一个名为 go_cref 的变量，类型为 c1 类的对象引用。程序运行时，首先使用 create object 关键字创建了一个 c1 类的对象，并将它的引用赋值给 go_cref 变量。
*然后，使用 call method 关键字调用 go_cref 对象中的 meth 方法，输出一条信息 "class test"。这段代码的含义是创建一个 c1 类的实例，并调用它的 meth 方法输出内容 "class test"。


*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

*-----------------------------------------------------------------------*
*                 CLASS book DEFINITION
*-----------------------------------------------------------------------*
CLASS book DEFINITION.

  PUBLIC SECTION.
    TYPES: ty_price TYPE p LENGTH 10 DECIMALS 2.

    DATA: title     TYPE string,
          author    TYPE string,
          publisher TYPE string,
          price     TYPE p DECIMALS 2.

    METHODS:
      print_info.
ENDCLASS.

*-----------------------------------------------------------------------*
*                   CLASS book IMPLEMENTSTION
*-----------------------------------------------------------------------*
*通过 DATA 定义的属性为实例属性，ABAP 中使用 -> 符号调用对象实例的属性或方法
class book IMPLEMENTATION.
  method constructor.
    me->title     = title.
    me->author    = author.
    me->publisher = publisher.
    me->price     = price.
  endmethod.

  method set_price.
    me->price = new_price.
  endmethod.

  method print_info.
    WRITE: / 'Title:', title.
    WRITE: / 'Author: ', author.
    WRITE: / 'Pulisher: ', publisher.
    WRITE: / 'Price: ', price.
  endmethod.
endclass.

start-of-selection.
  data: book1 type ref to book,
        book2 type ref to book.

  create object book1
    exporting title     = '窗边的小豆豆'
              author    = '黑柳彻子'
              publisher = '南海出版公司'
              price     = '39.5'.

  create object book2
    exporting title     = '人间失格'
              author    = '太宰治'
              publisher = '作家出版社'
              price     = '18.8'.

  book1->print_info(  ).

  book2->set_price( '22.0' ).
  book2->print_info(  ).





*公有部分 PUBUIC SELECTION
*保护部分 PROTECTED SELECTION 只能被类及派生类中的方法使用
*私有部分 PRIVATE SELECTION 只能被类本身的方法所使用
*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

*class declarations   类的申明
CLASS application DEFINITION.  "dedinition定义
  PUBLIC SECTION.     "确定组件可见性
  " 在一个类的所有成员中，应只有一部分是可以被类外元素获得并进行操作，
  " 而另一部分内容则被分装在类的内部，没有接口功能，只供类自身使用。
    METHODS:show_test.
  PRIVATE SECTION.
    DATA test(100) TYPE c VALUE 'This is my first ABAP Object'.
ENDCLASS.

*-----------------------------------------------------------------------*
*CLASS Definitions   类的定义
*-----------------------------------------------------------------------*
CLASS application IMPLEMENTATION.    "类实现部分
  METHOD show_test.
    WRITE test.
  ENDMETHOD.
ENDCLASS.

*-----------------------------------------------------------------------*
*Global Data Declaration   全局定义申明
*-----------------------------------------------------------------------*
DATA ob_app TYPE REF TO application.

*-----------------------------------------------------------------------*
*Event Block START-OF-SELECTION
*-----------------------------------------------------------------------*
START-OF-SELECTION.
  CREATE OBJECT ob_app.
  CALL METHOD ob_app->show_test.





*属性是在类内部的数据对象，用于描绘类的状态。
*对于实例属性，使用data语句定义，语法与数据对象声明相同，
*对于静态属性，则使用CLASS-DATA语句进行定义。
*属性在类的声明部分进行定义。
class vehicle definition.
  public section.
    class-data class_name type c value 'vehicle'.  "静态属性是整个类共同持有的共享空间，任意对象修改，都会影响其他对象。
  PROTECTED section.
    data speed type i.   "实例属性是每个对象各自持有的独立空间，对象单方面修改不影响其他对象。
ENDCLASS.
" 上述代码在类vehicle中定义了一个静态属性class_name与实例属性speed。
" 除data语句外，也可以使用constant语句定义类常量，类常量不能在编译和运行期内修改
" 必须在类定义时指明其值，因此其性质类似静态属性。
" 也可用types语句，属于静态属性

*类的方法需要在类的声明和实现部分进行定义，在类的声明部分说明方法的参数接口，
*在类的实现部分则通过abap代码完成具体功能，
*方法的关键字为METHODS 和CLASS-METHODS,实现部分代码在语句METHOD和ENDMETHOD之间定义。
" 方法声明的语法结构如下：
methods meth
  IMPLEMENTATION...i TYPE type...
  exporting...e TYPE type...
  changing...c TYPE type ...
  exceptions...x...
" 该语句定义了方法meth及其参数接口，该接口中的各个参数选项（importing、exporting等）的意义及使用
" 方式与功能模块参数接口中的对应选项相当类似（调用功能模块），但没tables参数。
" 在方法实现部分，不需要重复定义这个接口。
method emth
   ...
   <abap statement>
   ...
endmethod.




*&---------------------------------------------------------------------*
*& Report ZDEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo.

CLASS vehicle DEFINITION.      "类的声明，声明一个类以及此类中的方法。
  PUBLIC SECTION.
    CLASS-DATA class_name(10) TYPE c VALUE 'Vhicle'.
    METHODS: accelerate,       "类的方法，指明类具有的功能。
      show_speed.       "指明此类中有两个方法
  PROTECTED SECTION.
    DATA speed TYPE i.
ENDCLASS.

*-----------------------------------------------------------------------*
CLASS vehicle IMPLEMENTATION.   "类的定义，定义类中方法的具体执行。
  METHOD accelerate.            "定义此类中的方法 'METHODS' 并且将方法命名为 'accelerate'
    speed = speed = 1.          "此方法定义属性speed的值等于speed + 1.
  ENDMETHOD.
  METHOD show_speed.
    WRITE: / 'Speed: ',speed.   "此方法定义输出 'Speed：'并且输出speed的值。
  ENDMETHOD.
ENDCLASS.

DATA ob_1 TYPE REF TO vehicle.  "声明了一个引用变量，并没有创建。

*-----------------------------------------------------------------------*
START-OF-SELECTION.
  CREATE OBJECT ob_1. "创建引用对象
  CALL METHOD ob_1->accelerate.
  CALL METHOD ob_1->show_speed.
*输出Speed：1
*如果将accelerate和show_speed互换，则输出Speed：0.
*由此可以看出方法执行顺序与 'CALL METHOD'顺序有关。
