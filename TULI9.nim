# Typedef for a ExprC
type
   ExprC = ref object of RootObj

# Typedef for a Value
type
   Value = ref object of ExprC

   NumV = ref object of Value
      n: int

   BoolV = ref object of Value
      b: bool

   StrV = ref object of Value
      s: string

# Beginning of the interp function
proc interp(exp : ExprC) : Value =
   if exp of NumV:
      return NumV(exp)
   elif exp of BoolV:
      return BoolV(exp)
   elif exp of StrV:
      return StrV(exp)

# Test Cases
assert(NumV(interp(NumV(n: 5))).n == 5)
