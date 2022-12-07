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

architecture=$(uname -a)

count_pcpu=$(grep "physical id" /proc/cpuinfo | wc -l)
count_vcpu=$(grep "processor" /proc/cpuinfo | wc -l)

mem_use=$(free --mega | grep "Mem" |  awk '{print $3}')
mem_total=$(free --mega | grep "Mem" | awk '{print $2}')
mem_prcnt=$(free --mega | grep "Mem" | awk '{printf("%.2f%%", $3/$2*100)}')

disk_use=$(df -Bm | grep "^/dev" | grep -v "/boot" | cut -d 'M' -f3 | awk '{result += $1} END {print result}')
disk_total=$(df -Bg | grep "^/dev" | grep -v "/boot" | cut -d 'G' -f2 | awk '{result += $2} END {print result}')
disk_prcnt=$(df -Bm | grep "^/dev" | grep -v "/boot" | awk '{use += $3} {total += $2} END {printf("%d%%", use/total*100)}')

cpu_load=$

last_boot=$

lvm_use=$

tcp=$

usr_log=$

network=$

sudo=$

wall "	#Architecture: $architecture
	#CPU Physical : $count_pcpu
	#vCPU : $count_vcpu
	#Memory Usage: $mem_use/${mem_total}MB ($mem_prcnt)
	#Disk Usage: $disk_use/${disk_total}Gb ($disk_prcnt)
	#CPU load: $cpu_load
	#Last boot: $last_boot
	#LVM use: $lvm_use
	#Connexions TCP : $tcp
	#User log: $user_log
	#Network: $network
	#Sudo : $sudo"
