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
  #-----print the line for testing.
    
        #-------if the line starts with LINE:    
  {

    if($1 == "VERTEX" || $1 == "POINT" || $1 == "LINE" || $1 == "3DFACE"){
        print "\n"
        skipping =1
        face_verticies=0;
        aFACE = 0
        if($1 == "3DFACE"){
            aFACE = 1
            print "I AM A FACE"
        }
        else {
            aFACE = 0
            print "I AM NOT"
        }

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
            skipping = 0
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
            getline

        if ($1 == "12") { 
            getline
            x3= $1
            getline
        }
        if ($1 == "22") { 
            getline
            y3= $1
            getline
        }
        if ($1 == "32") { 
            getline
            z3= $1
            getline
        }
        if ($1 == "13") { 
            getline
            x4= $1
            getline
        }
        if ($1 == "23") { 
            getline
            y4= $1
            getline
        }
        if ($1 == "33") { 
            getline
            z4= $1
            getline
        }


            



        print x1, y1, z1
        if (!skipping)
        print x2, y2, z2


        if(aFACE){

        print x3, y3, z3
        print x4, y4, z4
        }

        print "\n"

  }    
  }
END {
    #---------- Cleanup code goes here
    #print "element vertex", vertex_count+2
    #print "end_header"
    print("verticies: ",verticies )
    print("faces: ",faces )
}
