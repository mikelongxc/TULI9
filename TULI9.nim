# Typedef for a ExprC
type
   ExprC = ref object of RootObj

# Typedef for a Value
type
   Value = ref object of ExprC

   NumV = ref object of Value
      num*: int

# Beginning of the interp function
proc interp(exp : ExprC) : Value =
   if exp of NumV:
      return NumV(exp)

discard interp(NumV(num: 5))
