liste=$(cat liste.txt)
IFS=$'\n' 
for i in $liste 
do  
file=$(echo $i | cut -f1)
ind=$(echo $i | cut -f2)

echo $ind" Start"

R11=$(ls ../../../Data_Rna-seq_Proteogam/Biodiv/Data/L004/$file*_R1.fastq.gz)
R12=$(ls ../../../Data_Rna-seq_Proteogam/Biodiv/Data/L006/$file*_R1.fastq.gz)
R21=$(ls ../../../Data_Rna-seq_Proteogam/Biodiv/Data/L004/$file*_R2.fastq.gz)
R22=$(ls ../../../Data_Rna-seq_Proteogam/Biodiv/Data/L006/$file*_R2.fastq.gz)
echo $R11" extraction"
time gunzip -k -c $R11 > ./tmp/$ind\R1_tmp.fastq
echo $R12" extraction"
time gunzip -k -c $R12 >> ./tmp/$ind\R1_tmp.fastq
echo $R21" extraction"
time gunzip -k -c $R21 > ./tmp/$ind\R2_tmp.fastq
echo $R22" extraction"
time gunzip -k -c $R22 >> ./tmp/$ind\R2_tmp.fastq

echo $ind" Qual filtering"
time ./Python27/python.exe ./qualqmoy.py 16.99 ./tmp/$ind\R1_tmp.fastq ./tmp/$ind\R2_tmp.fastq $ind

echo $ind" Delete tmp"
rm ./tmp/$ind\R1_tmp.fastq ./tmp/$ind\R2_tmp.fastq


echo $ind" Finished"




done






