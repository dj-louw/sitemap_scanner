#!/bin/bash
echo "Sitemap.xml url testing script"

infile=$1
outfile=$2
rm $outfile > /dev/null

output=$(xmllint --xpath "//loc" $infile | awk -F'</?loc>' '{for(i=2;i<=NF;i++) if ($i != "") print $i}')

numlines=$(echo "$output" | wc -l)
echo "number of URLs to test: $numlines"

errors=0
counter=0

while read -r line; do
	{
		echo -n "."
		((--numlines))
		number=$(curl -I $line 2>/dev/null| head -n 1 | cut -d$' ' -f2)
		echo "$number --> $line" >> $outfile

		if [ $number != "200" ]; then
			((++errors))
		fi
	} &

	((counter++))
	if [ $counter -gt 10 ]; then
		wait
		echo -n ","
		counter=0 
	fi

done <<< "$output"
wait

echo -e "\nnumber of errors found: $errors"
echo "number of errors found: $errors" >> $outfile
