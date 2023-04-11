#!/bin/awk -f

BEGIN {
    RS = "\n"
    # Initialization code goes here

    print "ply"
    print "format ascii 1.0"
    print "element vertex 0"
    print "property float x"
    print "property float y"
    print "property float z"
    print "element face 0"
    print "property list uchar int vertex_index"
    print "end_header"
    verticies=0
    faces=0
}
    # Main processing code goes here

        #if the line starts with 3DFACE:    
$1 == "3DFACE" {
    #adding 1face & 4verticies if a face is found cuz a face is 4 verticies.
    verticies=verticies+4
    faces=faces+1
        #print the line for testing.
        print $1
        next
    printf("4 %d %d %d %d\n \n", verticies-4, verticies-3, verticies-2, verticies-1)

    }
        #if the line starts with LINE:    
    $1 == "LINE" {
        #print the line for testing.
        print $1
        getline
        getline
        getline
        if ($1 == "10") { 
            getline 
            x1 = $1 }
        getline
        if ($1 == "20") { getline
        y1 = $2 }
        getline
        if ($1 == "30") { getline
        z1 = $1 }
        getline
        if ($1 == "11") { getline
        x2 = $1 }
        getline
        if ($1 == "21") { getline
        y2 = $1 }
        getline
        if ($1 == "31") { getline
        z2 = $1 }
        print x1, y1, z1
        print x2, y2, z2
        print "2 " ++vertex_count " " ++vertex_count+1
        ++edge_count

    }
        #if the line starts with VERTICES:     
    $1 == "VERTEX" {
        #print the line for testing.
        print $1

        print $2,$3
        x = $2
        y = $3
        z = $4
        print x, y, z
    }
        #if the line starts with CIRCLE:    
    $1 == "CIRCILE" {
        #print the line for testing.
        print $1
    }


END {
    # Cleanup code goes here

    print("verticies: ",verticies )
    print("faces: ",faces )
}
