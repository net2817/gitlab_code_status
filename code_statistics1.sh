#!/bin/bash
master_dev='master'
date_star='2018-11-01'
date_end='2018-11-30'
path1=`find /home/gitlab_data/ -name "*.git"`
echo '' > /home/total.txt
#echo $path1
##arr=($a)用于将字符串$a分割到数组$arr ${arr[0]} ${arr[1]} ... 分别存储分割后的数组第1 2 ... 项 ，${arr[@]}存储整个数组。变量$IFS存储着分隔符，这里我们将其设为逗号 "," OLD_IFS用于备份默认的分隔符，使用完后将之恢复默认。
OLD_IFS="$IFS" 
IFS=" " 
arr=($path1) 
IFS="$OLD_IFS" 
for s in ${arr[@]} 
do 
#echo "$s" 
    cd $s
    user1=`git log  --pretty='%aN' | sort | uniq `
	OLD_IFS="$IFS1"
	IFS1=" "
	arr1=($user1)
	IFS="$OLD_IFS1"
	for s1 in ${arr1[@]}
	do
	    #echo "$s1" 
	#	if [[ $s1 != *HEAD* ]]
	#	then
		total=`git log $master_dev --since ==$date_star --until=$date_end --author=$s1 --pretty=tformat: --numstat | awk '{ loc += $1 -$2 } END { printf loc }'`
		#total_temp1=`git log $master_dev --since ==$date_star --until=$date_end --author='$s1' --pretty=tformat: --numstat | awk '{ printf $1}'`
		#echo $total_temp1
#		echo '' > /home/total.txt
		#if [ -n "$total" ];
		#then
		echo $s1 $total >> /home/total.txt
		#fi
	#	fi
	    #user1=`git log --pretty='%aN' | sort | uniq `
	done
done
cat /home/total.txt | awk '{a[$1]+=$2}END{for(i in a)print i,a[i]}' > /home/total_end.txt
cat /home/total_end.txt |grep -v '\ 0' > /home/total_all.txt