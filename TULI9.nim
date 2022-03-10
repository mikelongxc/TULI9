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

# Typedef for a Value
type
   Value = ref object of ExprC
   
   NumV = ref object of Value
      num: int

   BoolV = ref object of Value
      b: bool

   PrimV = ref object of Value
      op: proc

type
   Env = ref object of RootObj
      next: Env
      name: string
      val: Value

   CloV = ref object of Value
      parms: array
      body: ExprC
      env: Env


# Beginning of the interp function
proc interp(exp : ExprC, env : Env = Env()) : Value =
   if exp of NumV:
      return NumV(exp)
   elif exp of BoolV:
      return BoolV(exp)

# Test Cases
assert(NumV(interp(NumV(num: 5))).num == 5)
assert(BoolV(interp(Boolv(b: true))).b)
assert(not BoolV(interp(Boolv(b: false))).b)
