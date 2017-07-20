let creeps : string array = [%bs.raw{|Object.keys(Game.creeps)|}]
let creepsArray = creeps
let creepsObject = [%bs.raw{|Game.creeps|}]
(* let creepsObj : *)
let spawns : string array = [%bs.raw{|Object.keys(Game.spawns)|}]
let spawnsArray : string array = spawns
let spawnsObject = [%bs.raw{|Game.spawns|}]
let arrayFilter (filter : 'a -> bool) (array : 'a array) : 'a array =
  let list = Array.to_list array in
  let filteredList = List.filter filter list in
  Array.of_list filteredList

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

type roomObject =
  {
    id : string;
  }

type room =
  {
    name : string;
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

(* Defines all possible roles available to Creeps *)
type role =
  | Harvester


(* Defines all of the memory fields I allow to be set on creeps programmatically *)
type memoryField =
  | Working of bool
  | Memory_Role of role
  | None

let roleToString (role : role) =
  match role with
  | Harvester -> "harvester"
  (* | Destination of roomObject *)

external defineMemoryHelper : string -> string -> string -> unit = "" [@@bs.module "./supplemental", "Supplement"]

let setMemoryField(creepName : string) (memory : memoryField) : unit =
  match memory with
  | Working(x) ->
    defineMemoryHelper(creepName)("working")
      (match x with
       | true -> "true";
       | false-> "false");
  | Memory_Role(occupation) ->
    defineMemoryHelper(creepName)("role")(roleToString occupation)
  | None -> ()


external spawnCreepHelper : string -> string array -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external spawnCreepWithMemoryHelper : string -> string array -> string array -> int = "" [@@bs.module "./supplemental", "Supplement"]
external doWatcher : string -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external getCreep: string -> creep = "" [@@bs.module "./supplemental", "Supplement"]
external getRoom: creep -> room = "" [@@bs.module "./supplemental", "Supplement"]

let spawnCreep(spawn : string) (body : bodyPart array) : unit =
  let bodyCost = (arraySum(Array.map bodyPartToCost body )) in
  spawnCreepHelper (spawn) (Array.map bodyPartToString body) ;
  Js.log("Spawning a new creep!")

let spawnCreepWithMemory(spawn : string) (body : bodyPart array) (mfa : memoryField) : int =
  spawnCreepWithMemoryHelper(spawn)(Array.map bodyPartToString body)
  (match mfa with
    |   None -> [||];
    |   Memory_Role(role) -> ([|"role"; roleToString role|]);
    |   Working(x) -> ([|"working"; if x then "true" else "false"|]) )






type roomPosition =
  {
    x : int;
    y : int;
    roomName : string
  }

external get_carry : creep -> int = "carryCapacity" [@@bs.get]
external get_load : creep -> int = "energy" [@@bs.get] [@@bs.scope "carry"]
external get_room : creep -> room = "room" [@@bs.get]
external getStructureTypeHelper : roomObject -> string = "structureType" [@@bs.get]
external get_closest : creep -> roomObject array -> roomObject = "findClosestByPath" [@@bs.send] [@@bs.scope "pos"]
external harvest : creep -> roomObject -> int = "harvest" [@@bs.send]
external moveTo : creep -> roomObject -> unit = "moveTo" [@@bs.send]
external findHelper : room -> int -> roomObject array = "find" [@@bs.send]
external transfer : creep -> roomObject -> string -> int = "transfer" [@@bs.send]
let get_struct_type(r : roomObject) : structureConst =
  let structString = getStructureTypeHelper r in
  fromStringStructure structString

let find(r : room) (f : filterConst) : roomObject array  =
  findHelper r (toNumFilter f)

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
      let currentRoom = get_room creep in
      let energySources = find currentRoom FIND_SOURCES in
      let chosenSource  = Array.get energySources 0 in
      if load < carryCap then
        (if (harvest creep (chosenSource) = (toNumResult ERR_NOT_IN_RANGE)) then
           moveTo creep chosenSource)
      else
        let structureArray = find currentRoom FIND_STRUCTURES in
        let isSpawnOrExtension (ro : roomObject) : bool =
           match get_struct_type ro with
           | STRUCTURE_SPAWN     -> true;
           | STRUCTURE_EXTENSION -> true;
           | _                   -> false
         in
         let spawnsAndExtensions =  arrayFilter (isSpawnOrExtension) (structureArray)  in
         let  chosenStructure = Array.get spawnsAndExtensions 0 in
         Js.log(chosenStructure) ;
         ignore (transfer creep chosenStructure "energy") ;
         moveTo creep chosenStructure

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
