SCREEN 12
COLOR 1
FOR x = 1 TO 640
IF y < 480 AND y > 0 THEN PSET (x, 480 - ((200 * TAN(x * (3.141592653589793# / 180)) + 240)))
NEXT x

