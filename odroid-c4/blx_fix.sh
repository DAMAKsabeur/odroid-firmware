#!/bin/sh
if [ "$7" = "bl30" ]; then
	blx_bin_limit=40960
	blx01_bin_limit=13312
	echo "blx_bin_limit" $blx_bin_limit
    echo "blx01_bin_limit" $blx01_bin_limit
elif [ "$7" = "bl2" ]; then
	blx_bin_limit=57344
	blx01_bin_limit=4096
	echo "blx_bin_limit" $blx_bin_limit
    echo "blx01_bin_limit" $blx01_bin_limit
else
	echo "blx_fix name flag not supported!"
	exit 1
fi

# blx_size: blx.bin size, zero_size: fill with zeros
blx_size=`du -b $1 | awk '{print int($1)}'`
echo "blx_size" $blx_size

zero_size=$(($blx_bin_limit-$blx_size))
echo "zero_size" $zero_size

dd if=/dev/zero of=$2 bs=1 count=$zero_size
cat $1 $2 > $3
echo "3" $3
echo "1" $1
echo "2" $2
rm $2

blx01_size=`du -b $4 | awk '{print int($1)}'`
zero_size_01=$(($blx01_bin_limit-$blx01_size))
dd if=/dev/zero of=$2 bs=1 count=$zero_size_01
cat $4 $2 > $5

cat $3 $5 > $6

rm $2

exit 0
