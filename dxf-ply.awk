#!/bin/awk -f

BEGIN {
    # Initialization code goes here
    RS = "\n";
    FS = " ";
    print "ply"
    print "format ascii 1.0"
    print "element vertex 0"
    print "property float x"
    print "property float y"
    print "property float z"
    print "element face 0"
    print "property list uchar int vertex_index"
    print "end_header"
}

{
    # Main processing code goes here

    #if the line starts with 3DFACE:    
    $1 =="3DFACE" {
        #print the line for testing.
        print $1
    }
    $1 =="LINE" {
        #print the line for testing.
        print $1
    }
    $1 =="VERTICES" {
        #print the line for testing.
        print $1
    }
    $1 =="CIRCILE" {
        #print the line for testing.
        print $1
    }
}

END {
    # Cleanup code goes here
}
