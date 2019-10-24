#!/bin/bash
## chip2heat.sh
## Christophe Desterke_oct2019
## Dependencies: python > 3.7.3 deeptools > 3.3.1
## parameters : $1 : bigwig file ; $2 : bed file
##usage: sh chip2heat.sh exemple.bigwig exemple.bed

variable=${1}
if [ -z "${variable}" ]
then 
	echo "BIGWIG file not passed as parameter"
	exit 1
fi

variable=${2}
if [ -z "${variable}" ]
then 
	echo "BED file not passed as parameter"
	exit 1
fi

nom_fichier=$(echo $2 | sed -re 's/(.*).bed/\1/')
echo "--------------------"


log_file="log_file.log" 

echo "analyse du ficher = $nom_fichier" >> $log_file

date >> $log_file


echo "step1 : compute promoter matrix"
UPTIME1=`uptime`

computeMatrix reference-point -S $1 -R $2 --referencePoint TSS -a 5000 -b 5000 -out chip.tab.gz

echo "--------------------"
echo "step2 : process heatmap in png format"
UPTIME2=`uptime`


plotHeatmap -m chip.tab.gz -out output.png --heatmapHeight 15 --colorMap YlGnBu

echo "--------------------"
echo "step3 : process heatmap in pdf format"
UPTIME3=`uptime`

plotHeatmap -m chip.tab.gz -out output.pdf --heatmapHeight 15 --colorMap YlGnBu

echo "--------------------"
echo "step4 : process heatmap in svg format"
UPTIME4=`uptime`

plotHeatmap -m chip.tab.gz -out output.svg --heatmapHeight 15 --colorMap YlGnBu



##log

echo "---------------------------------">> $log_file
echo "log of the promoter heatmap pipeline">> $log_file
echo "analyse du ficher = $nom_fichier">> $log_file
echo "--------------------">> $log_file
cal
echo "--------------------"
echo "step1 : compute promoter matrix">> $log_file
echo "Uptime = $UPTIME1">> $log_file
echo "-------------"
echo "step2 : process heatmap in png format">> $log_file
echo "Uptime = $UPTIME2">> $log_file
echo "------------"
echo "step3 : process heatmap in pdf format">> $log_file
echo "Uptime = $UPTIME3">> $log_file
echo "------------"
echo "step4 : process heatmap in svg format">> $log_file
echo "Uptime = $UPTIME4">> $log_file
echo "------------"

 ##files processing

mkdir RESULTS
mv chip.tab.gz RESULTS
mv output.png RESULTS
mv output.pdf RESULTS
mv output.svg RESULTS
mv log_file.log RESULTS

cd RESULTS
mv log_file.log $(echo log_file.log | sed "s/\./".$nom_fichier"\./")
mv output.png $(echo output.png | sed "s/\./".$nom_fichier"\./")
mv output.pdf $(echo output.pdf | sed "s/\./".$nom_fichier"\./")
mv output.svg $(echo output.svg | sed "s/\./".$nom_fichier"\./")
mv chip.tab.gz $(echo chip.tab.gz | sed "s/\./".$nom_fichier"\./")

cd ..

mv RESULTS RESULTS_$nom_fichier

exit 0

