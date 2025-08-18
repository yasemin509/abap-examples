* 2 parametreli bir seçim ekranı tasarlanacak.
* Her iki parametreye de en fazla 10000 değeri girilebilecek.
* Parametrelerden biri zorunlu olacak.
* Sadece zorunlu parametre doldurulup çalıştırılırsa o sayının asal olup olmadığı ekrana basılacak.
* Her iki parametre de doldurulursa o 2 parametre arasındaki asal sayılar; bir satırda en fazla 10 sayı olacak şekilde ekrana bastırılacak.
*----------------------------------------------------------------------------------------------------------------------------------------------

PARAMETERS: p_num1 TYPE i OBLIGATORY,  " p_num1 parametresi zorunlu, p_num2 ise isteğe bağlı.
            p_num2 TYPE i.

AT SELECTION-SCREEN.  " Kullanıcı değerleri girdiğinde hemen çalışır, programın ana kısmına (START-OF-SELECTION) geçmeden önce. burda parametre kontrolü yapmak için kullandık.
  " max 10000 kontrolü
  IF p_num1 > 10000.
    MESSAGE 'En fazla 10000 değeri girilebilir!' TYPE 'E'.  " message kullandığımızda type belirlemek zorundayız. E: Error ile bunun bir hata mesajı olduğunu gösteririz.
  ENDIF.

  IF p_num2 > 10000.
    MESSAGE 'En fazla 10000 değeri girilebilir!' TYPE 'E'.
  ENDIF.

START-OF-SELECTION.

DATA: lv_start TYPE i,
      lv_end TYPE i.


IF p_num2 IS INITIAL.  " bir değişkenin boş (initial) olup olmadığını kontrol eder.
  lv_end = p_num1.
  lv_start = p_num1.
ELSE.
  " Küçükten büyüğe sıralama
  IF p_num1 <= p_num2.
    lv_start = p_num1.
    lv_end = p_num2.
  ELSE.
    lv_start = p_num2.
    lv_end = p_num1.
  ENDIF.
ENDIF.

DATA: lv_count TYPE i VALUE 0,
      lv_num TYPE i,
      lv_div TYPE i,
      lv_is_prime TYPE abap_bool VALUE abap_true.

DO lv_end - lv_start + 1 TIMES.
  lv_num = lv_start + sy-index - 1.

  lv_is_prime = abap_true.

  " 1 ve altı sayılar asal değildir
  IF lv_num <= 1.
    lv_is_prime = abap_false.
  ELSE.
    " 2’den n-1’e kadar bölünebiliyor mu
    DO lv_num - 2 TIMES.
      lv_div = sy-index + 1.
      IF lv_num MOD lv_div = 0.
        lv_is_prime = abap_false.
        EXIT.
      ENDIF.
    ENDDO.
  ENDIF.

  " Asal ise ekrana yazdır
  IF lv_is_prime = abap_true.
    WRITE: lv_num, ' '.
    lv_count = lv_count + 1.

    IF lv_count MOD 10 = 0.
      WRITE /.
    ENDIF.
  ENDIF.
ENDDO.

IF p_num2 IS INITIAL AND lv_count = 0.
  WRITE: p_num1, 'is not a prime number.'.
ENDIF.
