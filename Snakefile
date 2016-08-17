
SAMPLES = ['SRR3194428', 'SRR3194429', 'SRR3194430', 'SRR3194431']
INDEX = ['Homo_sapiens.GRCh38.cdna.all.fa.gz']

rule all:
	input:
		expand('output2/{sample}/abundance.h5',sample=SAMPLES),
                expand('output2/{sample}/abundance.tsv',sample=SAMPLES),
                expand('output2/{sample}/run_info.json',sample=SAMPLES),
		
rule parse:
	input:
		parser = 'parseReads.py',
		file = '{sample}'
	output:
		'{sample}R1.fasta',
		'{sample}R2.fasta'
	shell:
		'python {input.parser} {input.file}'

rule kallistoindex:
	input:
		fasta = '{index}',
	output:
		ind = '{index}.idx'
	shell:
		'../kallisto/kallisto index -i {output.ind} {input.fasta}'

rule kallistoquant:
	input:
                reads = '{sample}',
		indx = expand('{index}.idx', index=INDEX)
	output:
		'output2/{sample}/abundance.h5',
		'output2/{sample}/abundance.tsv',
		'output2/{sample}/run_info.json'
	shell:
		'../kallisto/kallisto quant -i {input.indx} -b 100 -o output2/{wildcards.sample} --single -l 187 -s 70 {input.reads}'

