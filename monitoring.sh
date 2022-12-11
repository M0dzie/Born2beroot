# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thmeyer <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/06 10:00:31 by thmeyer           #+#    #+#              #
#    Updated: 2022/12/06 18:12:15 by thmeyer          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/usr/bin/bash

architecture=$(uname -a)

count_pcpu=$(grep -c "physical id" /proc/cpuinfo)
count_vcpu=$(grep -c "processor" /proc/cpuinfo)

mem_use=$(free --mega | grep "Mem" |  awk '{print $3}')
mem_total=$(free --mega | grep "Mem" | awk '{print $2}')
mem_prcnt=$(free --mega | grep "Mem" | awk '{printf("%.2f%%", $3/$2*100)}')

disk_use=$(df -Bm | grep "^/dev" | grep -v "/boot" | awk '{use += $3} END {print use}')
disk_total=$(df -Bg | grep "^/dev" | grep -v "/boot" | awk '{total += $2} END {print total}')
disk_prcnt=$(df -Bm | grep "^/dev" | grep -v "/boot" | awk '{use += $3} {total += $2} END {printf("%d%%", use/total*100)}')

cpu_load=$(top -bn1 | grep "^%Cpu" | awk '{printf("%.1f%%", $2+$4)}')

last_boot=$(who -b | awk '{print $3,$4}')

lvm_count=$(lsblk | grep -c "LVM")
lvm_use=$(if [[ $lvm_count -eq 0 ]]; then echo "no"; else echo "yes"; fi)

tcp=$(ss | grep -c "tcp")

usr_log=$(who | wc -l)

IPv4=$(hostname -I)
MAC=$(ip addr | grep "link/ether" | awk '{print $2}')

sudo=$(journalctl -q _COMM=sudo | grep -c "COMMAND=")

wall "	#Architecture: $architecture
	#CPU Physical : $count_pcpu
	#vCPU : $count_vcpu
	#Memory Usage: $mem_use/${mem_total}MB ($mem_prcnt)
	#Disk Usage: $disk_use/${disk_total}Gb ($disk_prcnt)
	#CPU load: $cpu_load
	#Last boot: $last_boot
	#LVM use: $lvm_use
	#Connexions TCP : $tcp ESTABLISHED
	#User log: $usr_log
	#Network: IP $IPv4 ($MAC)
	#Sudo : $sudo cmd"
