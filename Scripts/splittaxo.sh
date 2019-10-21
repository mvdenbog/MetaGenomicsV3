SCRIPTDIR=/pasteur/projets/specific/PGP_Work/Scripts/

in_fasta=$1
taxo_labels=$2
taxo=$3
out_taxo=`basename ${taxo_labels}`

module load Python/2.7.8

if ([ $taxo == "Virus" ] || [ $taxo == Bacteria ] || [ $taxo == Fungi ]); then
grep -i ${taxo} ${taxo_labels} | cut -f 2 > ${out_taxo}.${taxo}.list
python2.7 ${SCRIPTDIR}/get_fasta_from_name_seq.py ${in_fasta} ${out_taxo}.${taxo}.list ${out_taxo}.${taxo}.fasta
fi

## Eukaryota:
if ([ $taxo == "Eukaryota" ]); then
grep '^C' ${taxo_labels} | grep -i eukaryota | grep -v -i fungi |  cut -f 2 > ${out_taxo}.Eukaryota.list
python2.7 ${SCRIPTDIR}/get_fasta_from_name_seq.py ${in_fasta} ${out_taxo}.Eukaryota.list ${out_taxo}.Eukaryota.fasta
fi;

## Fungi:
if ([ $taxo == "Fungi" ]); then
grep '^C' ${taxo_labels} | grep -i eukaryota | grep -v -i fungi |  cut -f 2 > ${out_taxo}.Eukaryota.list
python2.7 ${SCRIPTDIR}/get_fasta_from_name_seq.py ${in_fasta} ${out_taxo}.Eukaryota.list ${out_taxo}.Eukaryota.fasta
fi;

## Unclassifieds:
if ([ $taxo == "Unclassifieds" ]); then
grep '^U' ${taxo_labels} | cut -f 2 > ${out_taxo}.Unclassifieds.list
python2.7 ${SCRIPTDIR}/get_fasta_from_name_seq.py ${in_fasta} ${out_taxo}.Unclassifieds.list ${out_taxo}.Unclassifieds.fasta
fi;

if ([ $taxo == "Other" ]); then
grep '^C' ${taxo_labels} | grep -v -i virus | grep -v -i bacteria | grep -v -i fungi | grep -v -i eukaryota | cut -f 2 > ${out_taxo}.Other.list
python2.7 ${SCRIPTDIR}/get_fasta_from_name_seq.py ${in_fasta} ${out_taxo}.Other.list ${out_taxo}.Other.fasta
fi;



