* Seçim ekranı olmayacak. Günün tarihini sistemden alarak ekrana aşağıdaki şekilde yazdırılacak. 
* “Bugün M (metin olarak) ayının dd (metin olarak, “beşinci” şeklinde) günü, YYYY”

DATA: lv_year TYPE c LENGTH 4,
      lv_month TYPE string,
      lv_day TYPE string,
      lv_text TYPE string.

" sistem tarihini parçalıyoruz burda (YYYYMMDD):
lv_year = sy-datum(4).   " ilk 4 karakteri alır. (YYYY)
lv_month = sy-datum+4(2).  " 4. indexten itibaren 2 karakter al. (MM)
lv_day = sy-datum+6(2).  " 6. indexten itibaren 2 karakter al. (DD)

" ayları case yapısı ile eşleştiriyoruz:
CASE lv_month.
  WHEN '01'. lv_month = 'Ocak'.
  WHEN '02'. lv_month = 'Şubat'.
  WHEN '03'. lv_month = 'Mart'.
  WHEN '04'. lv_month = 'Nisan'.
  WHEN '05'. lv_month = 'Mayıs'.
  WHEN '06'. lv_month = 'Haziran'.
  WHEN '07'. lv_month = 'Temmuz'.
  WHEN '08'. lv_month = 'Ağustos'.
  WHEN '09'. lv_month = 'Eylül'.
  WHEN '10'. lv_month = 'Ekim'.
  WHEN '11'. lv_month = 'Kasım'.
  WHEN '12'. lv_month = 'Aralık'.
ENDCASE.

" günler için de aynı işlemi yapıyoruz:
CASE lv_day.
  WHEN '01'. lv_text = 'birinci'.
  WHEN '02'. lv_text = 'ikinci'.
  WHEN '03'. lv_text = 'üçüncü'.
  WHEN '04'. lv_text = 'dördüncü'.
  WHEN '05'. lv_text = 'beşinci'.
  WHEN '06'. lv_text = 'altıncı'.
  WHEN '07'. lv_text = 'yedinci'.
  WHEN '08'. lv_text = 'sekizinci'.
  WHEN '09'. lv_text = 'dokuzuncu'.
  WHEN '10'. lv_text = 'onuncu'.
  WHEN '11'. lv_text = 'onbirinci'.
  WHEN '12'. lv_text = 'onikinci'.
  WHEN '13'. lv_text = 'onüçüncü'.
  WHEN '14'. lv_text = 'ondördüncü'.
  WHEN '15'. lv_text = 'onbeşinci'.
  WHEN '16'. lv_text = 'onaltıncı'.
  WHEN '17'. lv_text = 'onyedinci'.
  WHEN '18'. lv_text = 'onsekizinci'.
  WHEN '19'. lv_text = 'ondokuzuncu'.
  WHEN '20'. lv_text = 'yirminci'.
  WHEN '21'. lv_text = 'yirmibirinci'.
  WHEN '22'. lv_text = 'yirmiikinci'.
  WHEN '23'. lv_text = 'yirmiüçüncü'.
  WHEN '24'. lv_text = 'yirmidördüncü'.
  WHEN '25'. lv_text = 'yirmibeşinci'.
  WHEN '26'. lv_text = 'yirmialtıncı'.
  WHEN '27'. lv_text = 'yirmiyedinci'.
  WHEN '28'. lv_text = 'yirmisekizinci'.
  WHEN '29'. lv_text = 'yirmidokuzuncu'.
  WHEN '30'. lv_text = 'otuzuncu'.
  WHEN '31'. lv_text = 'otuzbirinci'.
ENDCASE.

" istenilen formatta ekrana yazdırma işlemini yapıyoruz:
WRITE: / 'Bugün', lv_month, 'ayının', lv_text, 'günü, ', lv_year.
