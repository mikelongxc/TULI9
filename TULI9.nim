# Struct for a NumV
type
   NumV* = object
      num: int

# Beginning of the interp function
proc interp(exp: int) =
   echo exp

interp(5)
