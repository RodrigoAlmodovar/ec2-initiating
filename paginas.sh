#!/bin/bash
COUNTER=1
function pageContent {

	case $COUNTER in
     1)
        echo "	
			<div>
				This is the site number $COUNTER
			</div> 
			<a href='$(($COUNTER+1)).html'> Next </a>
		"
     ;;
     40)
        echo "	
			<div>
				This is the site number $COUNTER
			</div>
			<a href='$(($COUNTER-1)).html'> Previous </a>
		"
     ;;
     *)
        echo "	
			<div>
				This is the site number $COUNTER
			</div>
			<a href='$(($COUNTER-1)).html'> Previous </a> 
			<a href='$(($COUNTER+1)).html'> Next </a>
		"
     ;;
  esac
}


echo "Creating the 40 sites..."
mkdir /usr/share/nginx/api 2> /dev/null
while [  $COUNTER -lt 41 ]; do	
	pageContent > /usr/share/nginx/html/api/"$COUNTER".html    	
   	let COUNTER=COUNTER+1 
done
echo "DONE!"