#!/bin/bash

SPECIES=$1

# echo $SPECIES

shift;

for f in $@
do

#     echo "Processing $f file ... "
    
    if ([ ${SPECIES} == "Virus" ] || [ ${SPECIES} == "Bacteria" ] || [ ${SPECIES} == "Fungi" ]); then
        grep -i ${SPECIES} ${f} 
    elif
        ([ ${SPECIES} == "Eukaryota" ]); then
        grep -i ${SPECIES} ${f} | grep -v -i fungi 
    elif ([ ${SPECIES} == "Other" ]); then
        grep -v -i virus  ${f} | grep -v -i bacteria | grep -v -i fungi | grep -v -i eukaryota 
    elif ([ ${SPECIES} == "Unclassifieds" ]); then
        grep -i unclassified  ${f} 

    fi
    
done
exit 0
