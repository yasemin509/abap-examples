* Write a program that reverses the text entered on the selection screen and prints it on the screen.
* As in the examples below :
*  stressed → desserts
*  strops → sports
*  racecar → racecar

PARAMETERS: pa_text TYPE string.

DATA: lv_reversed TYPE string,
      lv_length   TYPE i,
      lv_index    TYPE i,
      lv_char     TYPE c LENGTH 1.

lv_length = strlen( pa_text ).

DO lv_length TIMES.
  lv_index = lv_length - sy-index.    " sy-index: döngü sayacı ve 1'den başlar. lv_index son karakteri tutmuş oluyor burda.   
  lv_char  = pa_text+lv_index(1).     " diğer dillerin aksine + operatörü birleştirme olarak değil, substring olarak kullanılıyor. yani sondan başlayıp 1 karakter al demek.
  CONCATENATE lv_reversed lv_char INTO lv_reversed.  " iki stringi birleştirip lv_reversed içerisine yazıyor.
ENDDO.

WRITE: / 'ORIGINAL:', pa_text.
WRITE: / 'REVERSED:', lv_reversed.
