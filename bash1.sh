#!/usr/bin/bash



# 2 inputs:


#if [[ $? == 0  ]]; then
#    echo $?
 #   echo "commad  ran succ"
#else
 #   echo $?
  #  echo "command didnt run succ"
#fi

#declare NAME="MARO"
#echo ${NAME}

#declare fileext=${1##*.}
#echo "${fileext}"
#
#if [[ "hello world" == *"world"* ]]; then
 #   echo "hello world" contains: "world"
#fi

declare exten
declare listfiles=`ls -a  /home/marwan/test1`

mkdir /home/marwan/test1/pdfs
mkdir /home/marwan/test1/jpgs
mkdir /home/marwan/test1/txts
mkdir /home/marwan/test1/misc

for file in ${listfiles} ; do
    
    
    
     exten=${file##*.}
    case "${exten}" in
        txt)
            mv "${file}" /home/marwan/test1/txts
            echo "File moved to /txts"
        ;;
        
       jpg)
           mv "${file}" /home/marwan/test1/jpgs
           echo "File moved to /jpg"

        ;;
        pdf)
            mv "${file}" /home/marwan/test1/pdfs
            echo "File moved to /pdf"
  
       ;;
       sh)
            
  
       ;;
       "")
        mv "${file}" /home/marwan/test1/misc
          
   esac
    
done
echo "test1/"
echo "`ls -f -a */`"

