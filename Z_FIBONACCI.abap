* En fazla 5 karakterli numerik değer girilebilecek 1 değişkeniniz ve rakam girebileceğiniz bir başka değişkeniniz olacak. Program çalıştırıldığında Fibonacci dizilimine göre (kendinden önceki 2 sayıyı toplayarak gider) aşağıdaki gibi bir ekran oluşmalı.
* Değişken1: 100 (Maksimum Numara)
* Değişken2: 6 (Kırılım Sayısı)

* 1             2             3              5             8             13

* 21           34           55           89

*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PARAMETERS: p_val TYPE n LENGTH 5,
            p_num TYPE n LENGTH 1.

DATA: lv_a TYPE i VALUE 1,  " ilk değer her zaman 1 olur
      lv_b TYPE i VALUE 2,  " 2.değer her zaman 2'dir
      lv_next TYPE i,
      lv_cnt TYPE i.    " kırılım için sayaç tutuyoruz

WRITE lv_a.
lv_cnt = 1.

IF p_num > 1.    " kırılım değeri 1 olmadığı sürece 2 değerini de yazdır
  WRITE lv_b.
  lv_cnt = lv_cnt + 1.
ENDIF.

DO.
  lv_next = lv_a + lv_b.   " fibonacci kuralına göre iki değerin toplamı 3.değer olarak yazılır
  IF lv_next > p_val.
    EXIT.
  ENDIF.

  WRITE lv_next.
  lv_cnt = lv_cnt + 1.

  IF lv_cnt = p_num.
    NEW-LINE.
    lv_cnt = 0.
  ENDIF.

  lv_a = lv_b.    " sırayla tüm değerleri toplayacağımız için ilk değer 2.değer konumuna geçiyor
  lv_b = lv_next.  " aynı mantıkla 2.değer de 3.değer yerine geçer

ENDDO.
