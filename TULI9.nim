# Typedef for a ExprC
type
   ExprC = ref object of RootObj

   IdC = ref object of ExprC
      sym: string

   AppC = ref object of ExprC
      fun: ExprC
      args: array

   CondC = ref object of ExprC
      ifCond: ExprC
      thenCond: ExprC
      elseCond: ExprC

   LamC = ref object of ExprC
      parms: array
      body: ExprC

type
   Env = ref object of RootObj

# Typedef for a Value
type
   Value = ref object of ExprC
   
   NumV = ref object of Value
      num: int

   StrV = ref object of Value
      str: string

   BoolV = ref object of Value
      b: bool

   CloV = ref object of Value
      parms: array
      body: ExprC
      env: Env

   PrimV = ref object of Value
      op: proc


# Beginning of the interp function
proc interp(exp : ExprC, env : Env = Env()) : Value =
   if exp of NumV:
      return NumV(exp)
   elif exp of BoolV:
      return BoolV(exp)
   elif exp of StrV:
      return StrV(exp)

# Test Cases
assert(NumV(interp(NumV(num: 5))).num == 5)
assert(BoolV(interp(Boolv(b: true))).b)
assert(not BoolV(interp(Boolv(b: false))).b)
assert(StrV(interp(StrV(str: "Hello World"))).str == "Hello World")
