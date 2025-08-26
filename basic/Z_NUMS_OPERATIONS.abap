* 1 parametreli bir seçim ekranı tasarlanacak.
* Parametre 100 karakter uzunluğunda olacak.
* Parametreye sizin belirleyeceğiniz bir ayraç ile (virgül, iki nokta, noktalı virgül, ünlem vs vs) sayılar girilecek.
* Girilen ayraca göre sayıları ayıracak ve şu değerleri ekrana basacaksınız:
* 1-En büyük sayı
* 2-En küçük sayı
* 3-Ortalama değer
* 4-Toplam değer
* 5-Büyükten küçüğe sıralanmış hali
* 6-Küçükten büyüğe sıralanmış hali
*-----------------------------------------------------------------------------------------------------------------------

PARAMETERS: p_nums TYPE c LENGTH 100 OBLIGATORY.

DATA: lt_str TYPE TABLE OF string,  " string olarak girilen değerleri bir tabloda (internal table) tutacağız
      lt_num TYPE TABLE OF i,       " bu değerleri integer'a dönüştürüp yine bir tabloda tutacağız
      lv_num TYPE i,
      lv_max TYPE i VALUE 0,
      lv_min TYPE i VALUE 0,
      lv_avg TYPE p DECIMALS 2,
      lv_cnt TYPE i VALUE 0,
      lv_sum TYPE i VALUE 0.

SPLIT p_nums AT ',' INTO TABLE lt_str. " girilen string değeri virgüle göre ayır

LOOP AT lt_str INTO DATA(lv_str).  " tabloyu gezer ve her değeri lv_str değişkenine atar.
  lv_num = lv_str.           " string-integer dönüşümü
  APPEND lv_num TO lt_num.   " integer'a dönüştürdüğümüz değerleri lt_num tablosuna ekliyoruz
ENDLOOP.

LOOP AT lt_num INTO lv_num.
  lv_cnt = lv_cnt + 1.

  lv_sum = lv_sum + lv_num.

  lv_avg = lv_sum / lv_cnt.

  IF lv_num > lv_max.
    lv_max = lv_num.
  ENDIF.
  IF lv_num < lv_min.
    lv_min = lv_num.
  ENDIF.

ENDLOOP.

WRITE: / 'Max. value: ', lv_max,
       / 'Min. value: ', lv_min,
       / 'Average value: ', lv_avg,
       / 'Sum value: ', lv_sum.

NEW-LINE.

SORT lt_num.  " default olarak kullanıldığında küçükten büyüğe doğru sıralar

WRITE: / 'Sorted from smallest to largest: '.

LOOP AT lt_num INTO lv_num.
  WRITE: / lv_num.
ENDLOOP.

NEW-LINE.

SORT lt_num DESCENDING.  " büyükten küçüğe sıralar

WRITE: / 'Sorted from largest to smallest: '.

LOOP AT lt_num INTO lv_num.
  WRITE: / lv_num.
ENDLOOP.
