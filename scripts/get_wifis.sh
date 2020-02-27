wifis=$(sudo iw wlp4s0 scan | grep "SSID:" | sort -u | awk '{$1 = ""; print $0;}' | sed 's/^ //g' | awk 'NF')

for elem in "${wifis[@]}"
do
	echo "$elem"
done
