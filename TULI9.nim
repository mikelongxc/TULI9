# Struct for a NumV
type
   NumV* = object
      num: int

# Beginning of the interp function
proc interp(exp: int) : NumV =
   case exp
      of 5: return NumV(num: exp)
      else: echo "Not a valid type!"

echo interp(5)
