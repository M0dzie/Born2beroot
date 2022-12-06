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

count_cpu=$(nproc --all)

mem_use=$(free --mega | grep "Mem" |  awk '{print $3}')
mem_total=$(free --mega | grep "Mem" | awk '{print $2}')
mem_prcnt=$(free --mega | grep "Mem" | awk '{printf("%.2f%%", $3/$2*100)}')

disk_use=$(df -h --total | grep "total" | awk '{print $3}' | grep -oE '[0-9]+')
disk_total=$(df -h --total | grep "total" | awk '{print $2}')
disk_prcnt=$(df -h --total | grep "total" | awk '{print $5}')

cpu_load=$

last_boot=$

lvm_use=$

tcp=$

usr_log=$

network=$

sudo=$

wall "	#Architecture: $architecture
	#CPU Physical : $count_cpu
	#vCPU : $count_cpu
	#Memory Usage: $mem_use/${mem_total}MB ($mem_prcnt)
	#Disk Usage: $disk_use/${disk_total}Gb ($disk_prcnt)
	#CPU load: $cpu_load
	#Last boot: $last_boot
	#LVM use: $lvm_use
	#Connexions TCP : $tcp
	#User log: $user_log
	#Network: $network
	#Sudo : $sudo"