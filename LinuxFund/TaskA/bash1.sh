#!/usr/bin/bash

#Bash Script to manage files and sort files in terms of their extenstion in seperate directorys 
# You can change the directory to yours or change the code to $1 ,,$2...$n


declare exten
declare listfiles=`ls -a  /home/marwan/test1`

if [ ! -d "/home/marwan/test1/pdfs" ]; then
    mkdir /home/marwan/test1/pdfs
fi
if [ ! -d "/home/marwan/test1/jpgs" ]; then
    mkdir /home/marwan/test1/jpgs
fi
if [ ! -d "/home/marwan/test1/txts" ]; then
    mkdir /home/marwan/test1/txts
fi
if [ ! -d "/home/marwan/test1/misc" ]; then
    mkdir /home/marwan/test1/misc
fi

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
echo "############test1/#####################"
echo "`ls -f -a */`"

