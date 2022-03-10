# Typedef for a Value
type
   Value = ref object of RootObj
      name: string

   NumV = ref object of Value
      num: int

type
   ExprC = ref object of RootObj
      name: string

   NumC = ref object of ExprC
      num: int
   StrC = ref object of ExprC
      num: string
   IdC = ref object of ExprC
      num: string

# Beginning of the interp function
proc interp(exp : Value) =
   if exp of NumV:
      echo "NumV"

interp(NumV(num: 5))
