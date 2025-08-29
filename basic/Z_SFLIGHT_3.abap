* Uçuş fiyatı para birimi USD olan uçuşlar için havayolu şirketi bazında toplam fiyatları Write-List formatında yazdıran program yazınız.

TYPES: BEGIN OF ty_result,
        carrid TYPE sflight-carrid,
        total_price TYPE p DECIMALS 2,
       END OF ty_result.

DATA: lt_sflight TYPE TABLE OF sflight,
      ls_sflight TYPE sflight,
      lt_result TYPE TABLE OF ty_result,
      ls_result TYPE ty_result.

" USD olan uçuşları seçiyoruz
SELECT carrid, price, currency
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE @lt_sflight
  WHERE currency = 'USD'.    " para birimi sadece USD olucak şekilde filtreliyoruz

CLEAR lt_result.


LOOP AT lt_sflight INTO ls_sflight.
  CLEAR ls_result.

  ls_result-carrid = ls_sflight-carrid.
  ls_result-total_price = ls_sflight-price.

  COLLECT ls_result INTO lt_result.   " aynı carrid değerlerini toplar.

ENDLOOP.

WRITE: / 'Havayolu Şirketi', 25 'Toplam Fiyat (USD)'.
WRITE: / '-----------------------------------------'.

LOOP AT lt_result INTO ls_result.
  WRITE: / ls_result-carrid, 25 ls_result-total_price.
ENDLOOP.
