# SplitFasta v1.0, 26 Feb 2013
# Splits one big Fasta by count sequences into multiple
# Author: Lev I. Uralsky (Institute of Molecular Genetics, Moscow, Russia)
# Usage: gawk -f splitFasta.awk input.fasta

BEGIN {
  if (!num) {
    num = 1000000; # number of sequences in one part
  }
  RS = ">";
  seq = 0;
  aLine[0];
  suff = sprintf("%d", 1);
}
{
  if ($0 != "") {
    seq++;
    aLine[seq] = ">" $0;
  }
  if (seq == num) {
    outFile = FILENAME "-" suff;
    for (seq=1; seq<=num; seq++) {
      printf("%s", aLine[seq]) >> outFile;
    }
    close(outFile);
    delete aLine;
    seq = 0;
    suff++;
  }
}
END {
  outFile = FILENAME "-" suff;
  for (seq=1; seq<=num; seq++) {
    printf("%s", aLine[seq]) >> outFile;
  }
  close(outFile);
}