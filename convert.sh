#!/bin/bash

# install catdoc pwgen by command:
# sudo apt-get install catdoc pwgen

if [ -z $1 ]
then
echo "try $0 filename.txt"
exit 1
fi

# конвертировать кириллицу в lowercase-транслит
function translit(){
echo $1 | iconv -t koi8-r | catdoc -d us-ascii -s koi8-r | tr '[:upper:]' '[:lower:]'
}

csv_fname=$(echo $1 | awk -F "." '{ print $1 ".CSV"}')

#echo $csv_fname

if [ -f $csv_fname ]
then
rm $csv_fname
fi
echo "username;password;firstname;lastname;email" > $csv_fname

while read line; do

#
firstname=$line

# замена пробелов на подчеркивания
line_=$(echo $line | sed 's/ /_/g')

# формирование логина вида familiya_imya_o
f_=$(echo $line_ | awk -F "_" '{print $1}')
i_=$(echo $line_ | awk -F "_" '{print $2}')
o_=$(echo $line_ | awk -F "_" '{print $3}')
o__=${o_:0:1}

login=$f_"_"$i_"_"$o__

firstname=$i_" "$o_
lastname=$f_

login_transl_=$(translit $login)
login_transl=$(echo $login_transl_ | sed "s/'//g")

email=$login_transl"@changeme.please"

pass=$( pwgen -vns1 8 )
#echo $pass

#echo $login_transl

#echo "$login_transl;$pass;$firstname;$lastname;$email"
echo "$login_transl;$pass;$firstname;$lastname;$email" >> $csv_fname


done < $1
