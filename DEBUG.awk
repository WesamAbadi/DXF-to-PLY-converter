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
    print "\n"
    verticies=0
    faces=0
}

{

    if ($1 ~ /^(VERTEX|POINT|LINE|3DFACE)$/) {
        print "\n"
        skipping =1
        face_verticies = 2
        aFACE = 0
        

    if ($1 ~ /^(3DFACE)$/){
        aFACE = 1
        faces++
    }

    

    print "----" $1


    getline
    getline
    getline

    if ($1 ~ /^ *10 *$/) {
        getline
        x[1] = $1
        getline
    }
    if ($1 ~ /^ *20 *$/) {
        getline
        y[1] = $1
        getline
    }
    if ($1 ~ /^ *30 *$/) {
        getline
        z[1] = $1
        getline
    }
    if ($1 ~ /^ *11 *$/) {
        skipping = 0
        getline
        x[2] = $1
        getline
    }
    if ($1 ~ /^ *21 *$/) {
        getline
        y[2] = $1
        getline
    }
    if ($1 ~ /^ *31 *$/) {
        getline
        z[2] = $1
        getline
    }
    if ($1 ~ /^ *12 *$/) {
        face_verticies++
        getline
        x[3] = $1
        getline
    }
    if ($1 ~ /^ *22 *$/) {
        getline
        y[3] = $1
        getline
    }
    if ($1 ~ /^ *32 *$/) {
        getline
        z[3] = $1
        getline
    }
    if ($1 ~ /^ *13 *$/) {
        face_verticies++
        getline
        x[4] = $1
        getline
    }
    if ($1 ~ /^ *23 *$/) {
        getline
        y[4] = $1
        getline
    }
    if ($1 ~ /^ *33 *$/) {
        getline
        z[4] = $1
        getline
    }





    if (aFACE) {
        for (i = 0; i <= face_verticies; i++) {
        print x[i], y[i], z[i]
    }

    if(faces ==3)
        print (face_verticies, face_verticies-3, face_verticies-2, face_verticies-1)
    else
        print (face_verticies, face_verticies-4, face_verticies-3, face_verticies-2, face_verticies-1)

        # for (i = 0; i < face_verticies; i++) {
        #     print "at" i+1 " : "
        #     if (y[i]!=0 && z[i]=0)
        #         print i* 3 + 1
        # else if (z[i]!=0){
        #         print i* 3 + 2
        # }
        # else 
        # print i * 3 + 0
        #index [i] = i* 3 + (i-1);
    #}
    #index = coordinate_index * dimensions + coordinate_dimension
    #print face_verticies, face_verticies-1, face_verticies-2, face_verticies-3

}
    else {
        print x[1], y[1], z[1]
    if (!skipping)
        print x[2], y[2], z[2]
    }
}
}
END {
    #---------- Cleanup code goes here
    #print "element vertex", vertex_count+2
    #print "end_header"
    print("\n\nEND\nverticies: ",verticies )
    print("faces: ",faces )
}
