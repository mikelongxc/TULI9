# Typedef for a ExprC
type
   ExprC = ref object of RootObj

type
   Env = ref object of RootObj

# Typedef for a Value
type
   Value = ref object of ExprC
   
   NumV = ref object of Value
      num*: int
   StrV = ref object of Value
      str*: string
   BoolV = ref object of Value
      v*: bool
   CloV = ref object of Value
      parms*: array
      body*: ExprC
      env*: Env
   PrimV = ref object of Value
      op*: proc

# Beginning of the interp function
proc interp(exp : ExprC) : Value =
   if exp of NumV:
      return NumV(exp)

discard interp(NumV(num: 5))
