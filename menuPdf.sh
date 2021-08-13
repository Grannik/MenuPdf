#!/bin/bash
 
 E='echo -e';e='echo -en';trap "R;exit" 2
 ESC=$( $e "\e")
 TPUT(){ $e "\e[${1};${2}H" ;}
 CLEAR(){ $e "\ec";}
# 25 возможно это 
 CIVIS(){ $e "\e[?25l";}
# это цвет текста списка перед курсором при значении 0 в переменной  UNMARK(){ $e "\e[0m";}
 MARK(){ $e "\e[45m";}
# 0 это цвет заднего фона списка
 UNMARK(){ $e "\e[0m";}
# ~~~~~~~~ Эти строки задают цвет фона ~~~~~~~~
 R(){ CLEAR ;stty sane;CLEAR;};
#R(){ CLEAR ;stty sane;$e "\ec\e[37;44m\e[J";};
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 HEAD(){ for (( a=1; a<=36; a++ ))
 do
 TPUT $a 1
        $E "\xE2\x94\x82                                           \xE2\x94\x82";
 done
 TPUT 3 2
        $E "$(tput setaf 2)  Справочник операции над PDF файлами   $(tput sgr 0)";
 TPUT 5 2
        $E "\033[36m Извлечь изображения \033[0m";
 TPUT 8 2
        $E "\033[36m Извлечь текст \033[0m";
 TPUT 23 2
        $E "\033[36m tesseract-ocr \033[0m ";
 TPUT 33 2
        $E "$(tput setaf 2)  Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter$(tput sgr 0) ";
 MARK;TPUT 1 2
        $E "  Программа написана на bash tput          ";UNMARK;}
   i=0; CLEAR; CIVIS;NULL=/dev/null
   FOOT(){ MARK;TPUT 36 2
# нижнее заглавие
        $E "  *** | Grannik | 2021.08.12 | ***         ";UNMARK;}
# это управляет кнопками ввер/хвниз
 i=0; CLEAR; CIVIS;NULL=/dev/null
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then 
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
#
  M0(){ TPUT  6 3; $e "                             \033[32m pdfimages \033[0m";}
  M1(){ TPUT  7 3; $e "                               \033[32m pdftppm \033[0m";}
#
  M2(){ TPUT  9 3; $e "                                \033[32m pdfocr \033[0m";}
  M3(){ TPUT 10 3; $e "                                 \033[32m pdftk \033[0m";}
  M4(){ TPUT 11 3; $e "                             \033[32m pdftohtml \033[0m";}
  M5(){ TPUT 12 3; $e "                              \033[32m pdftoppm \033[0m";}
  M6(){ TPUT 13 3; $e "                             \033[32m pdftotext \033[0m";}
  M7(){ TPUT 14 3; $e "                               \033[32m abiword \033[0m";}
  M8(){ TPUT 15 3; $e "                         \033[32m ebook-convert \033[0m";}
  M9(){ TPUT 16 3; $e "                                    \033[32m gs \033[0m";}
 M10(){ TPUT 17 3; $e "                               hocr2pdf ";}
 M11(){ TPUT 18 3; $e "                          pdftxtextract ";}
 M12(){ TPUT 19 3; $e "                             \033[32m pnmtojpeg \033[0m";}
 M13(){ TPUT 20 3; $e "                         \033[32m poppler-utils \033[0m";}
 M14(){ TPUT 21 3; $e "                              \033[32m pypdfocr \033[0m";}
 M15(){ TPUT 22 3; $e "                                  \033[32m qpdf \033[0m";}
#
 M16(){ TPUT 24 3; $e "                               Описание ";}
 M17(){ TPUT 25 3; $e "                              Установка ";}
 M18(){ TPUT 26 3; $e "                      Извлечение текста ";}
 M19(){ TPUT 27 3; $e "                        Работа с языком ";}
 M20(){ TPUT 28 3; $e "            Перечитать файлы циклом for ";}
 M21(){ TPUT 29 3; $e " Конвертировать текстовый файл \033[32mlowriter \033[0m";}
 M22(){ TPUT 30 3; $e "                            \033[32m xpdf-utils \033[0m";}
 M23(){ TPUT 31 3; $e "           Python PDF Handling Tutorial ";}
 M24(){ TPUT 32 3; $e "               Скрипт извлечения текста ";}
#
 M25(){ TPUT 34 3; $e " EXIT                                   ";}
# далее идет переменная LM=16 позволяющая выстраивать список в вертикаль.
LM=25
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
# Здесь необходимо следить за двумя перепенными 0) и S=M0 Они должны совпадать между собой и переменной списка M0().
        0) S=M0;SC;if [[ $cur == enter ]];then R;echo "
 Kомандa pdfimages с опцией -j. Команда:
 pdfimages -j primer.pdf pictures
";ES;fi;;
        1) S=M1;SC;if [[ $cur == enter ]];then R;echo "
 sudo apt-get install pdftppm
#
 Мы используем -png возможность указать, что мы хотим создавать файлы PNG.
 Имя файла нашего PDF — «turing.pdf».
 Мы будем называть наши файлы изображений «turing-01.png», «turing-02.png» и так далее:
pdftoppm -png turing.pdf turing
";ES;fi;;
        2) S=M2;SC;if [[ $cur == enter ]];then R;echo "
 Добавление репозитория и установка в Ubuntu:
 sudo add-apt-repository ppa:gezakovacs/pdfocr
 sudo apt-get update
 sudo apt-get install pdfocr

 Запуск ocr в файле
 pdfocr -i input.pdf -o output.pdf
";ES;fi;;
        3) S=M3;SC;if [[ $cur == enter ]];then R;echo "
 PDF Toolkit является удобным инструментом для работы с файлами PDF, который запускается из командной строки.
#
 sudo apt-get install pdftk
#
 Когда установка будет завершена, введите в командной строке следующую команду, заменив соответствующие части так, как указано ниже.
 pdftk /home/lori/Documents/secured.pdf input_pw password output /home/lori/Documents/unsecured.pdf
#
 Описание отдельных частей команды:
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 pdftk                                     | Название команды
 /home/lori/Documents/secured.pdf          | Полный путь и имя защищенного паролем файла PDF.
                                           | Замените его на полный путь и имя файла вашего защищенного паролем PDF-файла.
 input_pw password                         | Параметр для ввода пароля для защищенного файла PDF и пароль для открытия файла.
                                           |  Замените \"password\" паролем, используемым при открытия файла.
 output /home/lori/Documents/unsecured.pdf | Параметр для ввода пути и имени, которые вы хотите использовать
                                           | при генерации с помощью pdftk незащищенного файла PDF, за которым собственно
                                           | следуют полный путь и имя создаваемого незащищенного файла PDF.
                                           | Замените путь, указанный здесь, на полный путь и имя файла,
                                           | которые необходимы в вашем случае.
";ES;fi;;
        4) S=M4;SC;if [[ $cur == enter ]];then R;echo "
 Вытаскивает все изображения из PDF. Превращает все страницы в изображения:
 pdftohtml -c source.pdf target.html
#
 преобразовать PDF в HTML. Преобразование HTML в обычный текст может быть выполнено многими способами,
 например, с помощью lynx -dump file.html
";ES;fi;;
        5) S=M5;SC;if [[ $cur == enter ]];then R;echo "
 – обрабатывая pdf файл генерирует для каждой его страницы соответствующую картинку.
 Поддерживаются следующие форматы: ppm, pgm или pbm. По умолчанию используется ppm.
 При конвертировании можно указать диапазон страниц (флаги -f, -l), которые необходимо перевести в отдельные изображения,
 и даже задать координаты области на странице для преобразования (флаги -x, -y, -W, -H).
";ES;fi;;
        6) S=M6;SC;if [[ $cur == enter ]];then R;echo "
 попытается извлечь любой текст, найденный в PDF.
#
 sudo apt install poppler-utils
#
 преобразовать файл PDF в обычный текст:
 pdftotext -layout pdf-entrada.pdf pdf-salida.txt
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Преобразование в текст только диапазона страниц PDF
 будут используйте параметр -f (первая страница для конвертации) А -l (последняя страница для конвертации),
 за которым следует каждый вариант с номером страницы. Команда, которую следует использовать, будет примерно такой:
 pdftotext -layout -f P -l U pdf-entrada.pdf

 сохранить в текстовом формате заданное количество страниц pdf
 В предыдущей команде вам нужно будет замените буквы P и U на номера первой и последней страницы извлекать.
 Имя pdf-input.pdf Нам также придется изменить его и дать ему имя файла PDF, с которым мы хотим работать.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
";ES;fi;;
        7) S=M7;SC;if [[ $cur == enter ]];then R;echo "
 может быть вызван из командной строки для преобразования между любыми форматами, которые он может вводить из /export,
 и с соответствующим плагином импорта, включая PDF-файлы:
 abiword --to=txt file.pdf
";ES;fi;;
        8) S=M8;SC;if [[ $cur == enter ]];then R;echo "
 может конвертировать.PDF-файлы в виде обычного текста (или RTF или нескольких форматов электронных книг, таких как ePub и т.д.)
 sudo apt install calibre
";ES;fi;;
        9) S=M9;SC;if [[ $cur == enter ]];then R;echo "
 ниже команда должен преобразовать многостраничный PDF в отдельные файлы tiff.
 gs -SDEVICE=tiffg4 -r600x600 -sPAPERSIZE=letter -sOutputFile=filename_%04d.tif -dNOPAUSE -dBATCH -- filename
";ES;fi;;
       10) S=M10;SC;if [[ $cur == enter ]];then R;echo "
 Command 'hocr2pdf' not found, but can be installed with:
 sudo apt install exactimage
";ES;fi;;
       11) S=M11;SC;if [[ $cur == enter ]];then R;echo "
 pdftxtextract
";ES;fi;;
       12) S=M12;SC;if [[ $cur == enter ]];then R;echo "
 – одна из многочисленного семейства утилит pnmto* используемых для конвертации файлов формата ppm, pgm pbm 
 во что только душе угодно.
 Вот простенький bash скрипт который конвертирует pdf-файл в набор JPEG-картинок.
 Первый аргумент – pdf файл для конвертации, второй – папка в которую будут сложены jpeg-страницы.
 Если указанной директории не существовало – она будет создана.
 Если директория не указана – файлы будут складироваться в текущую папку.
";ES;fi;;
       13) S=M13;SC;if [[ $cur == enter ]];then R;echo "
sudo apt-get install poppler-utils 
#
 Следующая команда извлечёт все изображения из документа \"pdffile.pdf\" и поместит их в директорию /home/пользователь/pdfimages/:
 pdfimages -j pdffile.pdf ~/pdfimages/
 JPEG-файлы будут сохранены с расширением PPM через pdfimages, если вы не включите в команду параметр \"-j\" (для JPEG).
 Преимущество pdfimages в том, что он извлекает оригинальные изображения, как они встроены в PDF. Это очень полезно.
#
 А следующая команда извлечёт весь текст и поместит файл с таким же именем, как PDF,
 но с расширением TXT (pdffile.txt) в ту же директорию, как начальный файл
 pdftotext pdffile.pdf
";ES;fi;;
       14) S=M14;SC;if [[ $cur == enter ]];then R;echo "
 Лучший и самый простой способ использовать pypdfocr, он не меняет PDF pypdfocr your_document.pdf
 В конце вы получите еще один your_document_ocr.pdf , как вы хотите, с помощью текста с возможностью поиска.
 Приложение не меняет качество изображения. Увеличивает размер файла, добавляя текст наложения.
";ES;fi;;
       15) S=M15;SC;if [[ $cur == enter ]];then R;echo "
 это инструментальная программа, работающая в командной строке Linux,
 которая осуществляет преобразование одного файла PDF в другой эквивалентный файл PDF, сохраняя при этом содержимое файла.
 Этот инструмент позволяет шифровать и расшифровывать, оптимизировать для веб, а также разделять и объединять файлы PDF.
#
sudo apt-get install qpdf
#
После того, как программа QPDF будет установлена, введите в командной строке следующую команду:
qpdf –password=password –decrypt /home/lori/Documents/secured.pdf /home/lori/Documents/unsecured.pdf
#
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 qpdf                                       | Название команды
--------------------------------------------+-----------------------------------------------------------------------------------------
 --password=password                        | Параметр запроса пароля для открытия защищенного файла PDF.
                                            | После знака равенства укажите пароль для открытия файла.Примечание:
                                            | Перед параметром \"password\", слева от знака равенства, указывается два знака \"тире\".
 --decrypt /home/lori/Documents/secured.pdf | Запрос полного пути и имени файла PDF, из которого вы хотите удалить пароль.
                                            | Заменить полный путь и имя файла на те, что которые необходимы вам.
 /home/lori/Documents/unsecured.pdf         | Полный путь и имя файла к незащищенному файлу PDF файла, который будет создан.
                                            | Замените его на полный путь и имя файла,
                                            | который необходимы вам для указания незащищенного PDF файла, генерируемого QPDF.
";ES;fi;;
       16) S=M16;SC;if [[ $cur == enter ]];then R;echo "
 Это механизм оптического распознавания символов OCR (Optical Character Recognition)
";ES;fi;;
       17) S=M17;SC;if [[ $cur == enter ]];then R;echo "
 sudo apt-get install tesseract-ocr
 sudo apt-get install tesseract-ocr-cym
#
 Инсталляционный пакет называется «tesseract-ocr-» с сокращением языка, помеченным на конце.
 Чтобы установить файл с валлийским языком в Ubuntu, мы будем использовать:
 sudo apt-get install tesseract-ocr-cym
";ES;fi;;
       18) S=M18;SC;if [[ $cur == enter ]];then R;echo "
 tesseract recital-63.png recital --dpi 150
 tesseract bold-italic.png bold --dpi 150
";ES;fi;;
       19) S=M19;SC;if [[ $cur == enter ]];then R;echo "
 чтобы позволить tesseract знать язык, на котором мы хотим работать:
 tesseract hen-wlad-fy-nhadau.png anthem -l cym --dpi 150
#
 Если ваш документ содержит два или более языков (например, словарь валлийский-английский),
 вы можете использовать знак плюс (+) сказать tesseract добавить другой язык, вот так:
 tesseract image.png textfile -l eng+cym+fra
#
";ES;fi;;
       20) S=M20;SC;if [[ $cur == enter ]];then R;echo "
 for i in turing*.jpeg; do tesseract \"\$i\" \"text-\$i\" -l eng; done;
";ES;fi;;
       21) S=M21;SC;if [[ $cur == enter ]];then R;echo "
 lowriter --convert-to pdf filename.doc
#
 lowriter --convert-to pdf filename.txt
#
 Пакетное преобразование файлов:
 lowriter --convert-to pdf *.docx
";ES;fi;;
       22) S=M22;SC;if [[ $cur == enter ]];then R;echo "
Xpdf-utils
 является пакетом утилит для обработки файлов PDF, в составе которого есть конвертер файлов PDF в файлы PostScript (pdftops),
 экстрактор информации из документов PDF (pdfinfo), экстрактор изображений из документов PDF (pdfimages),
 конвертер из файлов PDF в текстовые файлы (pdftotext) и анализатор шрифтов PDF (pdffonts).
 Чтобы получить о каждом инструменте более подробную информации, введите команду ( указана в скобках для каждого инструмента)
 с последующим параметром \"--help\" (два тире перед help).
#
 xpdf-utils
#
 pdftops -upw password /home/lori/Documents/secured.pdf /home/lori/Documents/unsecured.pdf
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 pdftops                            | Название команды
 -upw password                      | Параметр запроса для ввода пароля защищенного файла PDF.
                                    | Замените \"password\" паролем, используемым при открытия файла.Примечание:
                                    | Перед \"upw\" указывается одно тире.
 /home/lori/Documents/secured.pdf   | Полный путь и имя защищенного паролем файла PDF.
                                    | Замените его на полный путь и имя файла вашего защищенного паролем файла PDF.
 /home/lori/Documents/unsecured.pdf | Полный путь и имя файла для незащищенного PDF файла, который будет создан.
                                    | Замените его полный путь и имя файла, который необходимо использовать
                                    | для незащищенного PDF файла, генерируемого pdftops.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Перед тем, как конвертировать файл postscript обратно в незащищенный файл PDF,
 необходимо установить конвертер Ghostscript Postscript-to-PDF Converter (ps2pdf)..
 Для этого введите в командной строке следующую команду:
 sudo apt-get install context
#
 ps2pdf /home/lori/Documents/unsecured.ps /home/lori/Documents/unsecured.pdf

 ps2pdf                             | Название команды
 /home/lori/Documents/secured.ps    | Полный путь и имя защищенного паролем файла postscript. Замените его на полный путь и имя файла вашего защищенного паролем файла postscript.
 /home/lori/Documents/unsecured.pdf | Полный путь и имя файла для незащищенного PDF файла, который будет создан. Замените его полный путь и имя файла, который необходимо использовать для незащищенного PDF файла, создаваемого из файла postscript с помощью пакета ps2pdf. 
#
 Перед тем, как конвертировать файл postscript обратно в незащищенный файл PDF,
 необходимо установить конвертер Ghostscript Postscript-to-PDF Converter (ps2pdf)..
 Для этого введите в командной строке следующую команду и нажмите клавишу Enter.
 sudo apt-get install context

 ps2pdf /home/lori/Documents/unsecured.ps /home/lori/Documents/unsecured.pdf

 ps2pdf                             | Название команды
 /home/lori/Documents/secured.ps    | Полный путь и имя защищенного паролем файла postscript.
                                    | Замените его на полный путь и имя файла вашего защищенного паролем файла postscript.
 /home/lori/Documents/unsecured.pdf | Полный путь и имя файла для незащищенного PDF файла, который будет создан.
                                    | Замените его полный путь и имя файла, который необходимо использовать для незащищенного PDF файла,
                                    | создаваемого из файла postscript с помощью пакета ps2pdf.
                                    | Будет создан незащищенный файл PDF, который будет помещен в каталог, указанный в команде.

";ES;fi;;
       23) S=M23;SC;if [[ $cur == enter ]];then R;echo "
Учебное пособие по работе с PDF-файлами в Python, которое включает:

▫ Извлечение текстов из PDF-файлов
▫ Извлечение изображений из PDF-файлов
▫ Извлечение таблиц из PDF-файлов
▫ Извлечение URL-адресов из PDF-файлов
▫ Извлечение страниц из PDF-файлов как изображения
▫ Создание файла PDF
▫ Добавление текста в PDF
▫ Добавление изображения в PDF
▫ Добавление таблиц в PDF
и многое другое...
#
https://github.com/prajwollamichhane11/PDF-Handling-With-Python
";ES;fi;;
       24) S=M24;SC;if [[ $cur == enter ]];then R;cat scripthocr2pdf;ES;fi;;
       25) S=M25;SC;if [[ $cur == enter ]];then R;clear;ls -l;exit 0;fi;;
 esac;POS;done
