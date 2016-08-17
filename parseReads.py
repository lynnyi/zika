
import io
import sys

infile = open(sys.argv[1], 'r')
readOneFile = open(sys.argv[1]+'R1.fasta', 'w')
readTwoFile = open(sys.argv[1]+'R2.fasta','w')

while True:
	line = infile.readline()
	if line:
		readOneFile.write(line)
		readOneFile.write(infile.readline())
		readTwoFile.write(infile.readline())
		readTwoFile.write(infile.readline())
	else:
		break

