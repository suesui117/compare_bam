task collectAlignmentSummary{
    File bamToSummarize
    File bamIndex

    String bamOut = "bamOut.bam"

    String bam_basename = basename("${bamToSummarize}", ".bam")

    # name the output file after the bam file sample name
    String output_file = bam_basename + ".txt"

    command {
        # echo the sample complete path to the output file (differentiates new from old tigris on samples with same name)
        echo ${bamToSummarize} > ${output_file}

        # append the samtool results to the output file
        /usr/local/bin/samtools view -h ${bamToSummarize} | grep -v "^@RG" | sed "s/\tRG:Z:[^\t]*//" | samtools sort -n -o ${bamOut}
        /usr/local/bin/samtools view ${bamOut} | md5sum >> ${output_file}
    }

    output{
        File bamFile_1 = "${output_file}"
    }
    runtime{
        docker: "386451404987.dkr.ecr.us-east-1.amazonaws.com/compare-bams:1.9"
        zones: "us-east-1"
        cpu: "64"
        memory: "128G"
    }
}