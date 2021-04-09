                   .:                     :,                                          
,:::::::: ::`      :::                   :::                                          
,:::::::: ::`      :::                   :::                                          
.,,:::,,, ::`.:,   ... .. .:,     .:. ..`... ..`   ..   .:,    .. ::  .::,     .:,`   
   ,::    :::::::  ::, :::::::  `:::::::.,:: :::  ::: .::::::  ::::: ::::::  .::::::  
   ,::    :::::::: ::, :::::::: ::::::::.,:: :::  ::: :::,:::, ::::: ::::::, :::::::: 
   ,::    :::  ::: ::, :::  :::`::.  :::.,::  ::,`::`:::   ::: :::  `::,`   :::   ::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  :::::: ::::::::: ::`   :::::: ::::::::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  .::::: ::::::::: ::`    ::::::::::::::: 
   ,::    ::.  ::: ::, ::`  ::: ::: `:::.,::   ::::  :::`  ,,, ::`  .::  :::.::.  ,,, 
   ,::    ::.  ::: ::, ::`  ::: ::::::::.,::   ::::   :::::::` ::`   ::::::: :::::::. 
   ,::    ::.  ::: ::, ::`  :::  :::::::`,::    ::.    :::::`  ::`   ::::::   :::::.  
                                ::,  ,::                               ``             
                                ::::::::                                              
                                 ::::::                                               
                                  `,,`


http://www.thingiverse.com/thing:2847603
Tube cutter hand tool trapezoid blade by PredatorJr is licensed under the Creative Commons - Attribution - Non-Commercial license.
http://creativecommons.org/licenses/by-nc/3.0/

# Summary

this tool cuts tubes from 3 to 8 mm

clamp the blade with two M4 screws and the small cap or one single M3 screw (both are self tapping) 


the V2 includes the added case, that has a nose and the opposite notch in the cutter that just will help to keep the case on the cutter. I made the angle into the case that it won't slide easily off, but when I gonna shake it, it will slide. The notch should prevent that.
No other difference between both v1 and v2

If you like a completely closed case you just have to comment the last line within the difference(){ } that contains the roundedcube (after the 3 hull() )


Update 2018-04-07
Noticed that if you keep it in the case for a few days it could deform slightly so it opens not the full width as it was direct out of the printer.
Made from PLA, maybe other material have more strength in it or you need to print it with 3 or more perimeters.
It didn't get warm to get weak, it just was laying around.

# Print Settings

Printer Brand: Prusa
Printer: i3 MK3
Rafts: No
Supports: Yes
Resolution: 0.2
Infill: 10%

Notes: 
enable support, but set the interface pattern spacing from 0.2 to 0.8 or more to make it much easier to remove it from the small gap where the blade moves in

take a knife, a small saw or file and pull it through the shape to make it free of all supports.
even if the printer builds beautiful bridges, along the round edges it won't be clean in every case.

# Custom Section

## Libraries

roundedcube library to create different cubes with round edges, that's not difficult to make.

the second is within the main scad project: set the diameter and the length of drillers e.g. and it will create (set distance "abstand" and the exact size of the array into the for loop) cylindric objects with spheric top and bottom that are allighned along the bottom and the top. 

this part was used for the raaco assorter with the tool inlet, too. There you can find another useful example how to use it.