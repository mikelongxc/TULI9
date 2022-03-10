# Typedef for a ExprC
type
   ExprC = ref object of RootObj

   IdC = ref object of ExprC
      sym: string

   AppC = ref object of ExprC

   CondC = ref object of ExprC

   LamC = ref object of ExprC

# Typedef for Env
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

   NullV = ref object of Value

# Looks up symbol in an environment
proc LookupEnv(env : Env, sym : IdC) : Value =
   return NumV(num: 1)


# Beginning of the interp function
proc interp(exp : ExprC, env : Env) : Value =
   if exp of NumV:
      return NumV(exp)
   elif exp of BoolV:
      return BoolV(exp)
   elif exp of StrV:
      return StrV(exp)
   elif exp of IdC:
      return LookupEnv(env, IdC(exp))
   elif exp of AppC:
      return NullV()
   elif exp of CondC:
      return NullV()
   elif exp of LamC:
      return NullV()
   

# Test Cases

var topEnv: Env
topEnv = Env()

assert(NumV(interp(NumV(num: 5), topEnv)).num == 5)
assert(BoolV(interp(Boolv(b: true), topEnv)).b)
assert(not BoolV(interp(Boolv(b: false), topEnv)).b)
assert(StrV(interp(StrV(str: "Hello World"), topEnv)).str == "Hello World")
