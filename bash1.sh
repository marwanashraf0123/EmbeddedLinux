#!/usr/bin/bash





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

