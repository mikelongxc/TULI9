
import sugar

#[ Type Definitions ]#

# Typedef for a ExprC
type
   ExprC = ref object of RootObj

   IdC = ref object of ExprC
      sym: string

   AppC = ref object of ExprC
      fun: ExprC
      args: seq[ExprC]

   CondC = ref object of ExprC
      ifCond: ExprC
      thenCond: ExprC
      elseCond: ExprC

   LamC = ref object of ExprC
      parms: seq[string]
      body: ExprC

# Typedef for a Value
type
   Value = ref object of ExprC
   
   NumV = ref object of Value
      num: int

   BoolV = ref object of Value
      b: bool

   StrV = ref object of Value
      str: string

   PrimV = ref object of Value
      op: (seq[Value]) -> Value

# Typedef for a Environment
type
   Env = ref object of RootObj
      next: Env
      name: string
      val: Value

   CloV = ref object of Value
      parms: seq[string]
      body: ExprC
      env: Env

# Let's create our top-env here
let top_env = Env(next: nil, name: "+", val: nil)

#[ Function Definitions ]#
proc interp(exp : ExprC, env : Env = top_env) : Value

# Lookup function utilizing our Env
proc lookup(env : Env, sym : string) : Value =
   if env.name == sym:
      return env.val
   elif env.next != nil:
      lookup(env.next, sym)
   else:
      return nil

proc extend(env : Env, syms : seq[string], vals : seq[Value]) : Env =
   if syms.high == -1:
      return env
   elif vals.high == -1:
      return env
   else:
      let newEnv = Env(next: env, name: syms[0], val: vals[0])
      return extend(newEnv, syms[1..^1], vals[1..^1])

# Interprets an AppC
proc interpApp(body : ExprC, args : seq[ExprC], env : Env) : Value = 
   var interpretedArgs: seq[Value]
   for a in args:
      interpretedArgs.add(interp(a, env))
   
   var interpretedBody: Value
   interpretedBody = interp(body, env)

   if interpretedBody of PrimV:
      var fnBody: (seq[Value]) -> Value
      fnBody = PrimV(interpretedBody).op
      return fnBody(interpretedArgs)


# Beginning of the interp function
proc interp(exp : ExprC, env : Env = top_env) : Value =
   if exp of NumV:
      return NumV(exp)
   elif exp of BoolV:
      return BoolV(exp)
   elif exp of StrV:
      return StrV(exp)
   elif exp of IdC:
      return lookup(env, IdC(exp).sym)
   elif exp of AppC:
      return interpApp(AppC(exp).fun, AppC(exp).args, env)


# Interp Test Cases
assert(NumV(interp(NumV(num: 5))).num == 5)
assert(BoolV(interp(Boolv(b: true))).b)
assert(not BoolV(interp(Boolv(b: false))).b)

# (AppC (IdC '+) (list (NumV 1) (NumV 2)))

var args0: seq[NumV]
args0 = @[NumV(num: 1), NumV(num: 2)]
let app0 = AppC(fun: IdC(sym: "+"), args: @[(ExprC)NumV(num: 1),(ExprC)NumV(num: 2)])
echo ((NumV)interpApp(app0.fun, app0.args, top_env)).num

# (NumV)interp(app0, top_env).num == 3


# Env Extend Test Cases
let testSyms = @["a", "b", "c"]
let testVals = @[NumV(num: 1), BoolV(b: true), NumV(num: 3)]
let extendedEnv = extend(Env(next: nil, name: "root", val: StrV(str: "Begin")), testSyms, testVals)
assert(lookup(extendedEnv, "nonexistant") == nil)
assert(NumV(lookup(extendedEnv, "a")).num == 1)
assert(StrV(lookup(extendedEnv, "root")).str == "Begin")

# Env Lookup Test Cases
let testEnv1 = Env(next: nil, name: "hello", val: BoolV(b : true))
assert(BoolV(lookup(testEnv1, "hello")).b)
assert(lookup(testEnv1, "nonexistant") == nil)
let testEnv2 = Env(next: testEnv1, name: "world", val: NumV(num : 5))
assert(BoolV(lookup(testEnv2, "hello")).b)
let testEnv3 = Env(next: testEnv2, name: "bin", val: StrV(str : "tester"))
assert(NumV(lookup(testEnv3, "world")).num == 5)
assert(StrV(lookup(testEnv3, "bin")).str == "tester")
