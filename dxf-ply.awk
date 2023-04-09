#!/bin/awk -f

BEGIN {
    # Initialization code goes here
    RS = "\n";
    FS = " ";
    print "Initial testing";
}

{
    # Main processing code goes here
    print $1;
}

END {
    # Cleanup code goes here
}
