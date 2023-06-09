param (
    [Parameter(Mandatory = $true)]
    [string]$InputFilePath,     # Path to the input file

    [Parameter(Mandatory = $true)]
    [string]$OutputFilePath     # Path to the output file
)

$vertices = 0
$faces = 0
$face = ""
$object = ""
$indices = ""
$vertex_count = 0
$line_num = 0

$lines = Get-Content -Path $InputFilePath     # Read the lines from the input file

foreach ($line in $lines) {
    $x1 = $y1 = $z1 = $x2 = $y2 = $z2 = $x3 = $y3 = $z3 = $x4 = $y4 = $z4 = "NULL"
    $line_num++

    if ($line -match "^(VERTEX|POINT|LINE|3DFACE)$") {   # Check if the line represents a vertex or face
        $skipping = $true
        $face_vertices = 0
        $aFACE = $false

        if ($line -match "^(3DFACE)$") {
            $aFACE = $true
            $faces++
        }

        $x = $lines[$line_num+2]
        $y = $lines[$line_num+4]
        $z = $lines[$line_num+6]

        if ($x -match "^ *10 *$") {   # Check if the line contains x1, y1, z1 coordinates
            $skipping = $false
            $x1 = $lines[$line_num+3]
            $y1 = $lines[$line_num+5]
            $z1 = $lines[$line_num+7]
        }
        
        $x = $lines[$lines.IndexOf($line) + 9]
        if ($x -match "^ *11 *$") {   # Check if the line contains x2, y2, z2 coordinates
            $skipping = $false
            $x2 = $lines[$line_num + 9]
            $y2 = $lines[$line_num + 11]
            $z2 = $lines[$line_num + 13]
        }

        $x = $lines[$lines.IndexOf($line) + 15]
        if ($x -match "^ *12 *$") {   # Check if the line contains x3, y3, z3 coordinates
            $face_vertices++
            $x3 = $lines[$line_num + 15]
            $y3 = $lines[$line_num + 17]
            $z3 = $lines[$line_num + 19]
        }

        $x = $lines[$lines.IndexOf($line) + 21]
        if ($x -match "^ *13 *$") {   # Check if the line contains x4, y4, z4 coordinates
            $face_vertices++
            $x4 = $lines[$line_num + 21]
            $y4 = $lines[$line_num + 23]
            $z4 = $lines[$line_num + 25]
        }

        if ($aFACE) {   # If it's a 3DFACE, process the face data
            $face += "$x1 $y1 $z1`n$x2 $y2 $z2`n"
            if ($x3 -match '^\d+(\.\d+)?$') {   # Check if we have a valid 3rd vertex 
                $face += "$x3 $y3 $z3`n"
                $face_vertices++
            }
            if ($x4 -match '^\d+(\.\d+)?$') {   # Check if we have a valid 4th vertex
                $face += "$x4 $y4 $z4`n"
                $face_vertices++
            }
                
            $vertex_indices = $vertex_count
            $indices += "$face_vertices"
            for ($i = 0; $i -lt $face_vertices; $i++) {
                $indices += " $($vertex_indices + $i + 1)"   # Add vertex indices to the indices string
            }
            $indices += "`n"

            $vertex_count += $face_vertices   # Increment the vertex count
            $faces++    # Increment the face count
        }
        elseif (-not $skipping) {   # If not skipping, process the object data
            $object += "$x1 $y1 $z1`n"
            $vertex_count++
            if ($x2 -match '^\d+(\.\d+)?$') {
                $object += "$x2 $y2 $z2`n"
                $vertex_count++
            }
            if ($x3 -match '^\d+(\.\d+)?$') {
                $object += "$x3 $y3 $z3`n"
                $vertex_count++
            }
            if ($x4 -match '^\d+(\.\d+)?$') {
                $object += "$x4 $y4 $z4`n"
                $vertex_count++
            }
        }
    }
}

$header = @"
ply
format ascii 1.0
element vertex $vertex_count
property float x
property float y
property float z
element face $faces
property list uchar int vertex_indices
end_header

"@

$header + $object + $face + $indices | Out-File -FilePath $OutputFilePath    # Write the header, object data, face data, and indices to the output file
