#!/bin/bash

cut -d',' -f 1-11, 13-15 supervivents.csv > sortida.csv

awk {if ($video_error_or_removed !=  True) print} sortida.csv | wc -l

awk {NR == Ranking_Views}

awk {if ($Views <= 1000000) $Ranking_Views = "Bo"; elif ($Views <= 10000000) $Ranking_Views = "Exel·lent";
 else ($Ranking_Views = "Estrella"} sortida.csv

for 
($8 / $9)*100

