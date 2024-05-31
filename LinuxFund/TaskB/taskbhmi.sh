#!/usr/bin/bash



search_process()
{
    read -p "please enter search type (user/name/resources)" search_type
    read -p "Enter Certeria" c

    case "${search_type}" in
        name)
            echo "please enter a name of process"
           ps -eo pid,comm,%cpu,%mem,user | grep $c | grep -v grep
        ;;
        user)
        echo "please enter the name of user running process"
        ps -eo pid,comm,%cpu,%mem,user | grep $c | grep -v grep
        

        ;;
        resources)
        echo "please enter a precentage of cpu usage or mem usage"
        ps -eo pid,comm,%cpu,%mem,user | grep $c | grep -v grep

        ;;
    esac
    

}



while true; do

echo "#####################################  Process Menu  #####################################"

echo "4) Search a process using (name/usage/user)"
echo "5) Kill process"
echo "6) Real Time Monitoring ps will run in the background "




 read -p "Enter your choice: " choice
 case "${choice}" in
    
    4)
        search_process
    ;;
    5)
        
        read -p "Enter pid to kill " p_id_number
        kill "${p_id_number}"

    ;;
    6)
        echo "Run taskb.sh first in terminal then open new terminal and run this bash"

    ;;
 esac
 

done