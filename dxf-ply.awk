#!/bin/awk -f

BEGIN {         #BEGIN, execute once at the beginning of the program.
    RS = "\n"   #set record separator to newline
    verticies=0 #initialize the vertex count to 0
    faces=0     #initialize the face count to 0
    face = ""
    object = ""
    indices = ""
    vertex_count = 0
}

{
    if ($1 ~ /^(VERTEX|POINT|LINE|3DFACE)$/) {
        skipping =1         #flag to indicate whether to skip the next line...
                            #we skip incase we don't have anymore vertices/indices to read.

        face_verticies = 2  #number of vertices in the current face (initialized to 2)
        aFACE = 0           #flag to indicate whether the current object is a 3DFACE

                            #if it's a 3DFACE, set the flag and increment the face count
        if ($1 ~ /^(3DFACE)$/) {
            aFACE = 1
            faces++
        }

                            #read the x, y, and z coordinates of the file's vertex.
                            #we skip lines here with(getline) to avoid the section and layer num.
                            #note: next skips the next record, while getline reads it.

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
            skipping = 0    #reset the skipping flag.
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
            face_verticies++  #increment the number of vertices in the current face.
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

        if (aFACE) {            #print the face's verticies information.
            for (i = 1; i <= face_verticies; i++) {
                face = face x[i] " " y[i] " " z[i] "\n"
                vertex_indices[vertex_count] = vertex_count
                vertex_count++
            }
            if (face_verticies == 4) {
                indices = indices "4 " vertex_indices[vertex_count - 4] " " vertex_indices[vertex_count - 3] " " vertex_indices[vertex_count - 2] " " vertex_indices[vertex_count - 1] "\n"
            } else {
                indices = indices "3 " vertex_indices[vertex_count - 3] " " vertex_indices[vertex_count - 2] " " vertex_indices[vertex_count - 1] "\n"
            }
        } 
        else {                  #if not a face, print the object's verticies.
            object = object x[1] " " y[1] " " z[1] "\n"
            vertex_count++
            if (!skipping){
                object = object x[2] " " y[2] " " z[2] "\n"
                vertex_count++
            }
        }
    }
}

END{
    #print the PLY file header
    print "ply"
    print "format ascii 1.0"
    print "element vertex " vertex_count
    print "property float x"
    print "property float y"
    print "property float z"
    print "element face " faces
    print "property list uchar int vertex_indices"
    print "end_header \n"
    printf object
    printf face
    print indices
}