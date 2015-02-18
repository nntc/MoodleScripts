#!/bin/bash

if [ -z $1 ]
then
echo "try $0 filename.txt"
exit 1
fi


infile=$1

outfile_=$(echo $infile | awk -F "." '{print $1}')

outfile=$outfile_".xls"

tmp_html_file="tmp_"$outfile_".html"


echo '<html><head><meta charset="utf8"></head><body>' > $tmp_html_file

echo "<h2>"$outfile_"</h2>" >> $tmp_html_file

echo "<table border=\"1\" cellspacing=\"0\">" >> $tmp_html_file

echo "<thead><tr><td><b>Фамилия Имя Отчество:</b></td><td><b>Логин:</b></td><td><b>Пароль:</b></td><td><b>Емэйл:</b></td></tr></thead><tbody>" >> $tmp_html_file

while read line; do

l_=$(echo $line | awk -F ";" '{ print $1 }')
p_=$(echo $line | awk -F ";" '{ print $2 }')
f_=$(echo $line | awk -F ";" '{ print $4 }')
io_=$(echo $line | awk -F ";" '{ print $3 }')
fio_=$f_" "$io_
m_=$(echo $line | awk -F ";" '{ print $5 }')

if [ $l_ != "username" ]
then
echo "<tr><td>"$fio_"</td><td>"$l_"</td><td>"$p_"</td><td>"$m_"</td></tr>" >> $tmp_html_file
fi

done < $infile

echo "</tbody></table>" >> $tmp_html_file

echo '</body></html>' >> $tmp_html_file

libreoffice --headless --convert-to xls $tmp_html_file
mv "tmp_"$outfile_".xls" $outfile
rm $tmp_html_file
