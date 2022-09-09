##########################################################################################
# Command line split MCL Cluster Groups
# Version 0.1.0
# Author Jared Streich
# Jacobson Group, ORNL
# Created: 2021-04-08
# email: streich.jared@gmail.com, while at ORNL: ju0@ornl.gov
##########################################################################################

##### Usage:
# ./splitMCL.sh /dir/to/files [input.txt]  [output.txt]

##### Set directory
dir=$1

##### Input file
infile=$2

##### Output file
outfile=$3

##########################################################################################
######################################## Start Script ####################################
##########################################################################################

##### Set operating directory
cd $dir

##### Remove all positive signs in input file
sed 's|[+,]||g' $infile > noPlus.tmp

##### Loop through file clusters
i=1
while read p
do
        echo $p | cat > in_clust_${i}.tmp
        tr ' ' '\n' < in_clust_${i}.tmp | cat > transpose_${i}.tmp
        tr '_' '\t' < transpose_${i}.tmp | cat > delimited_${i}.tmp
        awk '{print $1}' delimited_${i}.tmp > pre_clmn_${i}.tmp
        awk -v I=$i '$1=I' pre_clmn_${i}.tmp > clust_clmn_${i}.tmp
        paste delimited_${i}.tmp clust_clmn_${i}.tmp > latlong_clust_${i}.tmp
        ((i=i+1))
done < noPlus.tmp


##### Create output file
cat latlong_clust_* > combined.tmp
mv combined.tmp $outfile


##### Remove temporary files
rm *.tmp


##########################################################################################
################################## Citation and Links ####################################
##########################################################################################

# 1. https://www.linuxquestions.org/questions/programming-9/transpose-row-to-column-753352/
# 2. https://www.theunixschool.com/2012/09/examples-how-to-change-delimiter-of-file-Linux.html
# 3. https://unix.stackexchange.com/questions/33110/using-sed-to-get-rid-of-characters
# 4. https://stackoverflow.com/questions/40700891/why-is-this-gsub-not-working-in-r/40700905
# 5. https://unix.stackexchange.com/questions/79642/transposing-rows-and-columns
# 6. https://stackoverflow.com/questions/1729824/an-efficient-way-to-transpose-a-file-in-bash
# 7. https://unix.stackexchange.com/questions/88142/command-to-transpose-swap-rows-and-columns-of-a-text-file
# 8. https://www.google.com/search?q=bash+command+line+transpose+line+into+column&oq=bash+command+line+transpose+line+into+column&aqs=chrome..69i57j33i160j33i299.26202j0j7&sourceid=chrome&ie=UTF-8
# 9. https://linuxhint.com/bash_for_each_line/