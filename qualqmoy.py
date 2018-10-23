from Bio import SeqIO
from collections import Counter
from collections import defaultdict
import sys
def mean (liste):
	numb=float(sum(liste))/float(len(liste))
	
	return numb

def createlistreads(file,value,listexcl):
	for record in SeqIO.parse(file, "fastq"):
		m=mean(record.letter_annotations["phred_quality"])

		
		if m<float(value) :

			listexcl.append(record.name)


def outputreads(file,listexcl1,listexcl2,outname):
	itR1=0
	itR2=0
	out=open(outname,"w")
	for record in SeqIO.parse(file, "fastq"):
		toexcl=0
		if itR1<len(listexcl1):
			if listexcl1[itR1]==record.id:
				itR1+=1
				toexcl=1
		if itR2<len(listexcl2):
			if listexcl2[itR2]==record.id:
				itR2+=1
				toexcl=1
		if 	not(toexcl):
			
			SeqIO.write(record, out, "fastq")
	out.close()	
value=sys.argv[1] #16.99
R1in=sys.argv[2]
R2in=sys.argv[3]
outname=sys.argv[4]
listeR1=[]
listeR2=[]

createlistreads(R1in,value,listeR1)
createlistreads(R2in,value,listeR2)


outputreads(R1in,listeR1,listeR2,outname+"_R1.fastq")
outputreads(R2in,listeR1,listeR2,outname+"_R2.fastq")

