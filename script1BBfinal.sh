#!/bin/bash

if [ $# -eq 0 ]; then
    cut -d',' -f1-11,13-15 supervivents.csv > sortida.csv
    echo "PAS 1 FET"

    registres_eliminats=$(awk -F',' '{if ($11 != "True") print}' sortida.csv | wc -l)
    awk -F',' '{if ($11 != "True") print}' sortida.csv > temporal.csv
    mv temporal.csv sortida.csv
    echo "S'han eliminat $registres_eliminats registres amb errors."
    echo "PAS 2 FET"

    awk -F',' 'BEGIN { OFS = ","} {
        if ($8 <= 1000000) $16 = "Bo";
        else if ($8 <= 10000000) $16 = "Excel·lent";
        else $16 = "Estrella";
        print
    }' sortida.csv > temporal.csv
    mv temporal.csv sortida.csv
    echo "PAS 3 FET"

    awk -F',' 'NR==1 {print $0",Rlikes,Rdislikes"}' sortida.csv > temporal.csv
    numero_lines=$(wc -l < sortida.csv)

    for (( i = 2; i <= numero_lines; i++ )); do
        line=$(sed -n "${i}p" sortida.csv)

        views=$(echo "$line" | cut -d',' -f8)
        likes=$(echo "$line" | cut -d',' -f9)
        dislikes=$(echo "$line" | cut -d',' -f10)

        if [[ -n "$views" && "$views" -gt 0 ]]; then
            Rlikes=$(( (likes * 100) / views ))
            Rdislikes=$(( (dislikes * 100) / views ))
        else
            Rlikes=0
            Rdislikes=0
        fi

        echo "$line,$Rlikes,$Rdislikes" >> temporal.csv
    done

    mv temporal.csv sortida.csv	
    echo "PAS 4 FET"
else 
    if [ ! -f "sortida.csv" ]; then
        echo "L'arxiu sortida.csv no existeix."
        exit 1
    fi

    search_term=$1
    linia_buscada=$(grep "$search_term" sortida.csv)

    if [ -n "$linia_buscada" ]; then
        echo "$linia_buscada" | cut -d',' -f3,6,8,9,10,16,17,18
    else
        echo "No s'han trobat coincidències."
    fi
fi
