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

   StrV = ref object of Value
      str: string

   BoolV = ref object of Value
      b: bool

   PrimV = ref object of Value
      op: proc


   NullV = ref object of Value



# Typedef for a Environment (and CloV)
type
   Env = ref object of RootObj
      next: Env
      name: string
      val: Value

   CloV = ref object of Value
      parms: array
      body: ExprC
      env: Env


# Lookup function utilizing our Env
proc lookup(env : Env, sym : IdC) : Value =
   if env.name == sym.sym:
      return env.val
   else:
      lookup(env.next, sym)


# Beginning of the interp function
proc interp(exp : ExprC, env : Env) : Value =
   if exp of NumV:
      return NumV(exp)
   elif exp of BoolV:
      return BoolV(exp)
   elif exp of StrV:
      return StrV(exp)
   elif exp of IdC:
      return NullV() #lookup(env, IdC(exp))
   elif exp of AppC:
      return NullV()
   elif exp of CondC:
      return NullV()
   elif exp of LamC:
      return NullV()


var topEnv: Env
topEnv = Env(next: nil, name: "hello", val: BoolV(b : true))
#[
# Interp Test Cases
assert(NumV(interp(NumV(num: 5), topEnv)).num == 5)
assert(BoolV(interp(Boolv(b: true), topEnv)).b)
assert(not BoolV(interp(Boolv(b: false), topEnv)).b)
]#

# Env Lookup Test Cases
let testEnv1 = Env(next: nil, name: "hello", val: BoolV(b : true))
assert(BoolV(lookup(testEnv1, IdC(sym: "hello"))).b)
