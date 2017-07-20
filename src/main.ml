open BaseTypes
open ConstantConv
open HelperFunctions
open Creep

let creeps : string array = [%bs.raw{|Object.keys(Game.creeps)|}]
let spawns : string array = [%bs.raw{|Object.keys(Game.spawns)|}]

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


external getSpawn: string -> spawn = "" [@@bs.module "./supplemental", "Supplement"]
external getRoomFromSpawn : spawn -> room = "room" [@@bs.get]
external getEnergyInRoom : room -> int = "energyAvailable" [@@bs.get]

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


let spawnCreepWithMemory(spawn : string) (body : bodyPart array) (mfa : memoryField) : int =
  spawnCreepWithMemoryHelper(spawn)(Array.map bodyPartToString body)
  (match mfa with
    |   None -> [||];
    |   Memory_Role(role) -> ([|"role"; roleToString role|]);
    |   Working(x) -> ([|"working"; if x then "true" else "false"|]) )


let get_struct_type(r : roomObject) : structureConst =
  let structString = getStructureTypeHelper r in
  fromStringStructure structString

let find(r : room) (f : filterConst) : roomObject array  =
  findHelper r (toNumFilter f)

let iterateCreeps () : unit =
  match Array.length creeps  with
  | 0 -> Js.log("There are no creeps to iterate over") ;
  | x -> () ;
  (* Js.log(creeps); *)
    for i=0 to x - 1 do
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
         let chosenStructure = Array.get spawnsAndExtensions 0 in
         ignore (transfer creep chosenStructure "energy") ;
         moveTo creep chosenStructure
    done

let iterateSpawns () : unit =
  for i=0 to Array.length spawns - 1 do
    let body = [|WORK; CARRY; MOVE; MOVE|] in
    let spawn = getSpawn (Array.get spawns i) in
    let room = getRoomFromSpawn spawn in
    let energyAvailable = getEnergyInRoom room in
    let bodyCost = arraySum (Array.map bodyPartToCost body ) in
    if bodyCost <= energyAvailable
    then (ignore (spawnCreepWithMemory (Array.get spawns i) body (Memory_Role(Harvester)) );
          Js.log("Spawning new creep"))
  done

let run () : unit =
  ignore (iterateSpawns());
  ignore (doWatcher(""));
  iterateCreeps()

let runEachTick : unit = run()
