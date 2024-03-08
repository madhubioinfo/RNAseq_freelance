SAMPLES = ["0H_Infected_Rep1", "0H_Infected_Rep2", "0H_Mock_Rep1","0H_Mock_Rep2","48H_Infected_Rep1","48H_Infected_Rep2","48H_Mock_Rep1","48H_Mock_Rep2","72H_Infected_Rep1","72H_Infected_Rep2","72H_Mock_Rep1","72H_Mock_Rep2"]

rule all:
    input:
        expand("/home/malarm/RNAseq/test/output/{sample}_R1_fastqc.zip", sample=SAMPLES),
        expand("/home/malarm/RNAseq/test/output/{sample}_R2_fastqc.zip", sample=SAMPLES),
        "/home/malarm/RNAseq/test/output/multiqc_report.html"



rule fastqc:
    input:
        "/home/malarm/RNAseq/{sample}_R1.fastq.gz",
        "/home/malarm/RNAseq/{sample}_R2.fastq.gz"
    output:
        "/home/malarm/RNAseq/test/output/{sample}_R1_fastqc.zip",
        "/home/malarm/RNAseq/test/output/{sample}_R2_fastqc.zip"
    shell:
        "fastqc {input} --outdir output"


rule multiqc:
    input:
        expand("/home/malarm/RNAseq/test/output/{sample}_R1_fastqc.zip", sample=SAMPLES),
        expand("/home/malarm/RNAseq/test/output/{sample}_R2_fastqc.zip", sample=SAMPLES)
    output:
        "/home/malarm/RNAseq/test/output/multiqc_report.html"
    shell:
        "multiqc -o output --filename multiqc_report {input}"

