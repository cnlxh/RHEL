#!/bin/bash

# Created by Xiaohui Li
# Contact me via e-mail: 939958092@qq.com
# Contact me via WeChat: lxh_chat


# setting course
read -p "Which course do you want to set: " course
echo "Setting course to $course"
rht-vmctl poweroff classroom -q &> /dev/null
rht-vmctl poweroff all -q &> /dev/null

rht-clearcourse 0 &> /dev/null
rht-setcourse $course &> /dev/null
if [ $? -ne 0 ];then
	echo "Cannot set course to $course"
	exit 1
fi

# difined servers vars
servers=`cat /etc/rht | grep RHT_VMS= | cut -d = -f 2 |tr -d '"'` 

# Starting classroom, please wait a moment

echo "Starting classroom, please wait a moment"
rht-vmctl fullreset classroom -q &> /dev/null

if [ $? -ne 0 ];then
	echo "Cannot reset classroom on your Computer, Please run 'rht-vmctl reset classroom -q' manually"
	exit 1
fi

while true;do ping -c1 classroom &> /dev/null;
	if [ $? -ne 0 ];then
		sleep 1;
	else
		break
	fi
done


# Starting bastion and utility, please wait a moment

echo "Starting bastion and utility, please wait a moment"

if echo $servers | grep -q bastion;then
	servers=$(echo $servers | sed 's/bastion //g')
	servers=$(echo $servers | sed 's/utility //g')
	rht-vmctl fullreset bastion -q &> /dev/null
	sleep 20s
	rht-vmctl fullreset utility -q &> /dev/null
	while true;do
		ping -c1 bastion &> /dev/null
		if [ $? -ne 0 ];then
			sleep 1
		else
			break
		fi
	done
	while true;do
		ping -c1 utility &> /dev/null
		if [ $? -ne 0 ];then
			sleep 1
		else
			break
		fi
	done
fi


# Starting workstation, please wait a moment

echo "Starting workstation, please wait a moment"

if echo $servers | grep -q workstation;then
	servers=$(echo $servers | sed 's/workstation //g')
	rht-vmctl fullreset workstation -q &> /dev/null
	while true;do
		ping -c1 workstation &> /dev/null
		if [ $? -ne 0 ];then
			sleep 1
		else
			break
		fi
	done
fi

echo "Starting the remaining virtual machines, please wait a moment"

for vm in $servers;do
	rht-vmctl fullreset $vm -q &> /dev/null
	while true;do
	ping -c1 $vm &> /dev/null
	if [ $? -ne 0 ];then
		sleep 1
	else
		break
	fi
	done
done

