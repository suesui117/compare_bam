import "src/tsk_collectAlignmentSummary.wdl" as co

workflow runQC{


    # File bam
    # File bai
    Array[Array[String]] sample_list


    scatter (samplelist in sample_list) {

        call co.collectAlignmentSummary{
            input:
                bamToSummarize = samplelist[0],
                bamIndex = samplelist[1]
        }

    }

}