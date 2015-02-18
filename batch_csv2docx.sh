#!/bin/bash

for i in $(ls *.CSV)
do
bash csv2docx.sh $i
done
