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
    print "property int vertex1"
    print "property int vertex2"
    print "property list uchar int vertex_index"
    print "end_header"
    verticies=0
    faces=0
}
    # -------Main processing code goes here

        #if the line starts with 3DFACE:    
$1 == "3DFACE" {
    #-------adding 1face & 4verticies if a face is found cuz a face is 4 verticies.
    # verticies=verticies+4
    # faces=faces+1
    face_verticies=0;
     #------print the line for testing.
        print "----"$1

        #--------skipping the layer id.
        getline
        getline
        getline

        #------checks for the initial and final verticies of the line.
        if ($1 == "10") { 
            face_verticies++;
            getline 
            x1 = $1 }
        getline
        if ($1 == "20") { 
            getline
            y1 = $1 }
        getline
        if ($1 == "30") { 
            getline
            z1 = $1 }
        getline
        if ($1 == "11") { 
            face_verticies++
            getline
            x2 = $1 }
        getline
        if ($1 == "21") { 
            getline
            y2 = $1 }
        getline
        if ($1 == "31") { 
            getline
            z2 = $1 }
        getline
        if ($1 == "12") { 
            face_verticies++
            getline
            x3 = $1 }
        getline
        if ($1 == "22") { 
            getline
            y3 = $1 }
        getline
        if ($1 == "32") { 
            getline
            z3 = $1 }
        getline
        if ($1 == "13") { 
            face_verticies++
            getline
            x4 = $1 }
        getline
        if ($1 == "23") { 
            getline
            y4 = $1 }
        getline
        if ($1 == "33") { 
            getline
            z4 = $1 }

        print x1, y1, z1
        print x2, y2, z2
        print x3, y3, z3
if(face_verticies==4){
        print x4, y4, z4

}
    #-----print the line for testing.

    printf("FACES IS:: %d %d %d %d\n \n",face_verticies, face_verticies-4, face_verticies-3, face_verticies-2, face_verticies-1)

    }
        #-------if the line starts with LINE:    
    $1 == "LINE" {
        #------print the line for testing.
        print "----"$1

        #--------skipping the layer id.
        getline
        getline
        getline

        #------checks for the initial and final verticies of the line.
        if ($1 == "10") { 
            getline 
            x1 = $1 }
        getline
        if ($1 == "20") { 
            getline
            y1 = $1 }
        getline
        if ($1 == "30") { 
            getline
            z1 = $1 }
        getline
        if ($1 == "11") { 
            getline
            x2 = $1 }
        getline
        if ($1 == "21") { 
            getline
            y2 = $1 }
        getline
        if ($1 == "31") { 
            getline
            z2 = $1 }

        print x1, y1, z1
        print x2, y2, z2
        # print "2 " ++vertex_count " " ++vertex_count+1
        # ++edge_count

    }
        #if the line starts with VERTICES/POINT:     
    $1 == "VERTEX" || $1 == "POINT"{
        skipping =true
        #print the line for testing.
        print "----"$1
        #--------skipping the layer id.
        getline
        getline
        getline

        #------checks for the initial and final verticies of the line.
        if ($1 == "10") { 
            getline 
            x1 = $1 }
        getline
        if ($1 == "20") { 
            getline
            y1 = $1 }
        getline
        if ($1 == "30") { 
            getline
            z1 = $1 }
        getline
        if ($1 == "11") { 
            skipping = false
            getline
            x2 = $1 
        getline
            }
        if ($1 == "21") { 
            getline
            y2 = $1 
        getline
            }
        if ($1 == "31") { 
            getline
            z2 = $1 }

        print x1, y1, z1
        if (skipping){
        print x2, y2, z2
            
        }

        
    }
   
        #if the line starts with CIRCLE:    
    $1 == "CIRCILE" {
        #print the line for testing.
        print $1
    }


END {
    #---------- Cleanup code goes here
    #print "element vertex", vertex_count+2
    #print "end_header"
    print("verticies: ",verticies )
    print("faces: ",faces )
}
