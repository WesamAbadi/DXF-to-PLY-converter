#!/bin/awk -f

BEGIN {
    # Initialization code goes here
    vertices=0
    faces=0
    FS=","
}

{
    # Main processing code goes here
    print $1
}

END {
    # Cleanup code goes here
}
