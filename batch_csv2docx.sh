#!/bin/bash

for i in $(ls *.CSV)
do
bash MoodleScripts/csv2docx.sh $i
done
