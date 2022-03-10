# Typedef for a Value
type
   Value = ref object of RootObj
      name: string

   NumV = ref object of Value
      num: int

# Beginning of the interp function
proc interp(exp : Value) =
   if exp of NumV:
      echo "NumV"

interp(NumV(num: 5))
