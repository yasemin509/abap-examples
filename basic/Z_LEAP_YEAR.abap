* Şu anda kullandığımız Gregoryen takvimine göre bir yılın artık yıl olup olmadığını belirlemek için aşağıdaki adımları izleyin:
* 1- Yıl 4 ile eşit bölünebilir ise, adım 2'e gidin. Aksi durumda, 5. adıma gidin.
* 2- Yıl 100 ile eşit bölünebilir ise, adım 3'e gidin. Aksi durumda, 4. adıma gidin.
* 3- Yıl 400 ile eşit bölünebilir ise, adım 4'e gidin. Aksi durumda, 5. adıma gidin.
* 4- Yıl artık yıldır (366 gün vardır).
* 5- Yıl artık yıl değildir (365 gün vardır).
*----------------------------------------------------------------------------------------------------------------------------------

PARAMETERS: p_year TYPE i OBLIGATORY.

START-OF-SELECTION.
 IF p_year MOD 4 = 0.
   IF p_year MOD 100 = 0.
     IF p_year MOD 400 = 0.
       WRITE: / p_year NO-GROUPING, ' artık yıldır.'.   " NO-GROUPING -> binlik ayırıcıyı kaldırır. bunu kullanmadığımızda girdiğimiz değer 1.992 şeklinde gözükür.
     ELSE.
       WRITE: / p_year NO-GROUPING, ' artık yıl değildir.'.
     ENDIF.
   ELSE.
     WRITE: / p_year NO-GROUPING, ' artık yıldır.'.
   ENDIF.
 ELSE.
       WRITE: / p_year NO-GROUPING, ' artık yıl değildir.'.
 ENDIF.
