# Struct for a NumV
type
   NumV* = object
      num: int

# Beginning of the interp function
proc interp(exp: int) : NumV =
   NumV(num: exp)

echo interp(5)
