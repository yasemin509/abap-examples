* En fazla 2 karakterli numerik değer girilebilecek 1 değişkeniniz ve rakam girebileceğiniz bir başka değişkeniniz olacak. Program çalıştırıldığında değişkenlerin değerlerine göre aşağıdaki gibi bir ekran oluşmalı.
* Değişken1: 18 (Maksimum Numara)
* Değişken2: 4 (Kırılım Sayısı)

* 1             2             3              4

* 5             6             7              8

* 9             10           11           12

* 13           14           15           16

* 17           18

*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PARAMETERS: p_val TYPE n LENGTH 2,  " max 2 karakterli nümerik değer. type olarak i ile length belirleyemiyoruz!
            p_num TYPE n LENGTH 1.  " sadece rakam girilebilir

AT SELECTION-SCREEN.
  " ilk değer kontrolü:
  IF p_val IS INITIAL AND p_val > 99.
    MESSAGE 'You can enter a maximum of 2 characters.(0-99)!' TYPE 'E'.
  ENDIF.

  " ikinci değer için kontrol:
  IF p_num IS INITIAL AND p_val > 9.
    MESSAGE 'You can only enter one characters.(0-9)!' TYPE 'E'.
  ENDIF.

START-OF-SELECTION.

DATA lv_bp TYPE i VALUE 0.  " lv_bp = breakpoint.

DO p_val TIMES.
    WRITE sy-index.  " sy-index değeri zaten 1'den başlıyor, girilen değere kadar yazdırabiliriz bu şekilde
    sy-index = sy-index + 1.
    lv_bp = lv_bp + 1.

  DO p_num TIMES.
    IF lv_bp = p_num.  " lv_bp 0'dan başlıyor ve girilen 2.değere eşit olduğunda alt satıra geçilmesini sağlıyor
      WRITE /.
      lv_bp = 0.       " her alt satıra geçme işleminden sonra sayacı sıfırlamamız gerekiyor yoksa sadece bir kez yapmış oluyor bu işlemi.
    ENDIF.
  ENDDO.
ENDDO.
