# DXF-to-PLY-converter  

## Running Command:  
``awk -f dxf-ply.awk input.dxf > output.ply 2> error.log``    


## Logic:  

##### Excracting x, y & z coordinates:  



##### Calcuating the indices of a face from a set of coordinates:  
``index = coordinate_index * dimensions + coordinate_dimension``   
eg:
```
(0.0, 0.0, 0.0) -> 0 * 3 + 0 = 0
(1.0, 0.0, 0.0) -> 1 * 3 + 0 = 3
(0.0, 1.0, 0.0) -> 2 * 3 + 1 = 7
(0.0, 0.0, 1.0) -> 3 * 3 + 2 = 11
```

---------------------------
## SOURCES:  
#### The PLY Polygon File Format:  

https://web.archive.org/web/20161204152348/http://www.dcs.ed.ac.uk/teaching/cs4/www/graphics/Web/ply.html  
http://paulbourke.net/dataformats/ply/ 
https://brainder.org/tag/ply/   

#### DXF:  
http://paulbourke.net/dataformats/dxf/dxf10.html  
http://paulbourke.net/dataformats/dxf/min3d.html  
http://images.autodesk.com/adsk/files/autocad_2012_pdf_dxf-reference_enu.pdf  
https://www.fileformat.info/format/dxf/egff.htm  



#### Useful tools:  
https://products.aspose.app/3d/conversion/dxf-to-ply  
FreeCAD: https://github.com/FreeCAD/FreeCAD  
meshlab: https://github.com/cnr-isti-vclab/meshlab  
