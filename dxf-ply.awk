#!/bin/awk -f

BEGIN {
    # Initialization code goes here
    FS=","
}

{
    # Main processing code goes here
    print $1
}

END {
    # Cleanup code goes here
}
