* 2 parametreli, 5 radio butonlu seçim ekranı tasarlanacak.
* Parametrelere en fazla 7 numerik karakter girilebilecek.
* 4 Radio buton 4 işlemi temsil edecek, 1 radio buton ise Mod işlemini temsil edecek.
* Girilen iki parametre seçilen işleme göre işleme sokulacak.
* Ekrana matematiksel olarak işlem ve sonucu yazılacak.
* Olası Matematiksel hatalar da kontrol edilip kullanıcıya bilgi verilecek.

PARAMETERS: p_num1 TYPE n LENGTH 7,
            p_num2 TYPE n LENGTH 7.


SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME.  " butonları bir çerçeve içerisine alır
PARAMETERS: rb_add RADIOBUTTON GROUP rb,
            rb_sub RADIOBUTTON GROUP rb,
            rb_mult RADIOBUTTON GROUP rb,
            rb_div RADIOBUTTON GROUP rb,
            rb_mod RADIOBUTTON GROUP rb.
SELECTION-SCREEN END OF BLOCK bl1.

DATA: lv_result TYPE i.

AT SELECTION-SCREEN.     " 0 girişini kontrol kısmını burda yapmamız gerekiyor.
  IF p_num2 = 0.
    MESSAGE 'Error: division by zero error!' TYPE 'E' DISPLAY LIKE 'I'.  " error mesajı ama popup şeklinde gözükecek
  ENDIF.

START-OF-SELECTION.

  IF rb_add = 'X'.
    lv_result = p_num1 + p_num2.
  ELSEIF rb_sub = 'X'.
    lv_result = p_num1 - p_num2.
  ELSEIF rb_mult = 'X'.
    lv_result = p_num1 * p_num2.
  ELSEIF rb_div = 'X'.
      lv_result = p_num1 / p_num2.
  ELSEIF rb_mod = 'X'.
      lv_result = p_num1 MOD p_num2.
  ENDIF.

  WRITE: / lv_result.
