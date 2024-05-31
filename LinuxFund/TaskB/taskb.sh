#!/usr/bin/bash


if [[ -f $1 ]]; then
    source $1
fi





process_list()
{
    
    clear
    ps -eo pid,comm,%cpu,%mem,user --sort=-%cpu  | awk  '
    NR {
        process_total+=1
        cpu_total+=$3;
        mem_total+=$4;
        print $0
        
    } 
    END {

    
        print "Total CPU Usage:", cpu_total "%"; 
        print "Total Memory Usage:", mem_total "%" 
        print "Total NUmber of process:", process_total ;

       

    }'
    
    sleep "${UPDATE_INTERVAL}"
    
}

check_TH() {
    
    echo "Checking for resource usage for the whole system..."
    echo "###############################################################################################################################"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | awk -v cpu_thresh=$CPU_ALERT_THRESHOLD -v mem_thresh=$MEMORY_ALERT_THRESHOLD '
        BEGIN {
            cpu_alert = 0;
            mem_alert = 0;
        }
        NR>1 {
            cpu_total+=$3;
            mem_total+=$4;
        }
        END {
            if (cpu_total > cpu_thresh && cpu_alert == 0) {
                printf "CPU Alert: High CPU Usage Detected\n";
                cpu_alert = 1;
            }
            else
            {
                printf "CPU is not overloaded\n"
            }
            if (mem_total > mem_thresh && mem_alert == 0) {
                printf "Memory Alert: High Memory Usage Detected\n";
                mem_alert = 1;
            }
            else
            {
                printf "Memory is not overloaded\n"
            }
        }
    '
    echo "###############################################################################################################################"
    sleep "${UPDATE_INTERVAL}"
}
check_TH_for_proc() {
    declare cpu_prec
    eclare mem_prec

    echo "Checking for resource usage for each process..."
    echo "###################################################################"

    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | while read -r  cpu mem; do

        #cpu_prec="${cpu%.*}"
        #mem_prec="${mem%.*}"
      
        if [[ $cpu > $CPU_ALERT_THRESHOLD_FOR_PROC ]]; then
            echo "Alert 1 $cpu"
        fi

        if [[ $mem > $MEMORY_ALERT_THRESHOLD_FOR_PROC ]]; then
            echo "Alert 2 $mem"
        fi
    done

    echo "################################################################################################################################"
    sleep "${UPDATE_INTERVAL}"
}
check_TH2_for_proc() {
    echo "Checking for resource usage for each process..."
    echo "###################################################################"

    
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | awk -v cpu_thresh=$CPU_ALERT_THRESHOLD_FOR_PROC -v mem_thresh=$MEMORY_ALERT_THRESHOLD_FOR_PROC '
    NR>1 {
        cpu = $3 + 0  # Convert to numeric value
        mem = $4 + 0  # Convert to numeric value

        if (cpu > cpu_thresh) {
            printf "CPU Alert: Process %s (PID: %s) is using %.2f%% CPU\n", $2, $1, cpu
        }
        if (mem > mem_thresh) {
            printf "Memory Alert: Process %s (PID: %s) is using %.2f%% Memory\n", $2, $1, mem
        }
    }'

    echo "###################################################################"
    sleep "${UPDATE_INTERVAL}"
}






while true; do
   process_list
   check_TH
    check_TH2_for_proc
done