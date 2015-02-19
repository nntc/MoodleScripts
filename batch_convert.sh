#!/bin/bash

for i in $(ls *.TXT)
do
bash MoodleScripts/convert.sh $i
done
