let creeps : string array = [%bs.raw{|Object.keys(Game.creeps)|}]
let creepsArray = creeps
let creepsObject = [%bs.raw{|Game.creeps|}]
(* let creepsObj : *)
let spawns : string array = [%bs.raw{|Object.keys(Game.spawns)|}]
let spawnsArray : string array = spawns
let spawnsObject = [%bs.raw{|Game.spawns|}]

open ConstantConv

let rec arraySumRecursive (numArray : int array) (currentSum : int) (currentIndex : int) : int =
  if Array.length numArray = currentIndex then currentSum
  else arraySumRecursive(numArray)(currentSum + Array.get numArray currentIndex)(currentIndex+1)
(* For convenience *)
let arraySum (numArray : int array) : int =
  arraySumRecursive(numArray)(0)(0)


type creep =
  {
    carryCapacity : int;
    name : string;
  }

type source =
  {
    id : string;
  }

(* From the wiki *)

type bodyPart =
  | MOVE
  | WORK
  | CARRY
  | ATTACK
  | RANGED_ATTACK
  | HEAL
  | TOUGH
  | CLAIM


let bodyPartToCost(part : bodyPart) : int =
  match part with
  | MOVE -> 50;
  | WORK -> 100;
  | ATTACK -> 80;
  | CARRY -> 50;
  | HEAL -> 250;
  | RANGED_ATTACK -> 150;
  | TOUGH -> 10;
  | CLAIM -> 600

let bodyPartToString(part : bodyPart) : string =
  match part with
  | MOVE -> "move" ;
  | WORK -> "work" ;
  | ATTACK -> "attack" ;
  | CARRY -> "carry" ;
  | RANGED_ATTACK -> "ranged_attack" ;
  | TOUGH -> "tough" ;
  | HEAL -> "heal" ;
  | CLAIM -> "claim"

external spawnCreepHelper : string -> string array -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external doWatcher : string -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external getCreep: string -> creep = "" [@@bs.module "./supplemental", "Supplement"]
external getSources : creep -> source array = "" [@@bs.module "./supplemental", "Supplement"]

let spawnCreep(spawn : string) (body : bodyPart array) : unit =
  let bodyCost = (arraySum(Array.map bodyPartToCost body )) in
  (* if bodyCost > *)
  spawnCreepHelper (spawn) (Array.map bodyPartToString body) ;
  Js.log("Spawning a new creep!")

(* Defines all possible roles available to Creeps *)
type role =
  | Harvester

(* Defines all of the memory fields I allow to be set on creeps programmatically *)
type memoryField =
  | Working of bool
  | Memory_Role of role

external defineMemoryHelper : string -> string -> string -> unit = "" [@@bs.module "./supplemental", "Supplement"]

  let setMemoryField(creepName : string) (memory : memoryField) : unit =
    match memory with
    | Working(x) ->
      defineMemoryHelper(creepName)("working")
        (match x with
        | true -> "true";
        | false-> "false");
    | Memory_Role(occupation) ->
      match occupation with
      | Harvester -> defineMemoryHelper(creepName)("role")("harvester")


type roomPosition =
  {
    x : int;
    y : int;
    roomName : string
  }

external get_carry : creep -> int = "carryCapacity" [@@bs.get]
external get_load : creep -> int = "energy" [@@bs.get] [@@bs.scope "carry"]
external harvest : creep -> source -> int = "harvest" [@@bs.send]
external moveTo : creep -> source -> unit = "moveTo" [@@bs.send]

let iterateCreeps () : unit =
  match Array.length creeps  with
  | 0 -> Js.log("There are no creeps to iterate over") ;
  | x -> Js.log("There are " ^ (string_of_int x) ^ " creeps currently") ;
  (* Js.log(creeps); *)
    for i=0 to Array.length creeps - 1 do
      let creepName = Array.get creeps i in
      let creep = getCreep(creepName) in
      let carryCap = get_carry creep in
      let load = get_load creep in
      let energySources = getSources(creep) in
      let chosenSource  = Array.get energySources 0 in
      if load < carryCap then
        if (harvest creep (chosenSource ) = (toNum ERR_NOT_IN_RANGE)) then
          moveTo creep chosenSource ;


      setMemoryField(creepName)(Working(false))

done

let iterateSpawns () : unit =
  (* match Array.length spawns with
  | 0 -> Js.log("There are no spawns to iterate over (should be untrue)") ;
  | x -> Js.log("There are " ^ (string_of_int x) ^ " spawns currently") ;  *)

    for i=0 to Array.length spawns - 1 do
      (* Js.log("One is named " ^ Array.get spawns i); *)
      let body = [|WORK; CARRY; MOVE; MOVE|] in
      spawnCreep(Array.get spawns i) body
    done



let run () : unit =
  (* ignore (let time : int = [%bs.raw{|Date.now()|}] in Js.log(time)) ; *)
  ignore (iterateSpawns());
  ignore (doWatcher(""));
  iterateCreeps()

let runEachTick : unit = run()
