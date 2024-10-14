#!/bin/bash

if (($# -eq 0)); then

	cut -d',' -f 1-11, 13-15 supervivents.csv > sortida.csv

	awk {if ($video_error_or_removed !=  True) print} sortida.csv | wc -l

	awk {NR == Ranking_Views}

	awk {if ($Views <= 1000000) $Ranking_Views = "Bo"; elif ($Views <= 10000000) $Ranking_Views = "Exel·lent";
 		else ($Ranking_Views = "Estrella"} sortida.csv"

	awk -F',' 'NR==1 {print $0",Rlikes,Rdislikes"}' "supervivents.csv" > "sortida.csv"

	numero_lines=$(wc -l < "$supervivents.csv")

	for (( i = 2; i <= numero_lines; i++ )); do
    		line=$(sed -n "${i}p" "$supervivents.csv")
    
     		echo "$line"  

		views=$(echo "$line" | cut -d',' -f8)   
    		likes=$(echo "$line" | cut -d',' -f9)   
    		dislikes=$(echo "$line" | cut -d',' -f10) 
    
    		if (( views > 0 )); then
        	Rlikes=$(( (likes * 100) / views ))
        	Rdislikes=$(( (dislikes * 100) / views ))
    	fi

    	echo "$line,$Rlikes,$Rdislikes" >> "sortida.csv"
	done
fi

else 
	if [ ! -f "sortida.csv" ]; then
    		echo "L'arxiu sortida.csv no existeix."
    		exit 1
	fi


	linia_buscada=$(grep "$search_term" sortida.csv)

	if [ -n "$linia_buscada" ]; then
    		echo "$linia_buscada" | cut -d',' -f1,2,3,4,5,6,7,8
	else
    		echo "No s'han trobat coincidències."
	fi
fi


