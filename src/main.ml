open BaseTypes
open ConstantConv
open HelperFunctions
open Room
open RoomObject
open Spawn
open Creep

(* Gets both creeps and spawns using raw JS code *)
let creeps : string array = [%bs.raw{|Object.keys(Game.creeps)|}]
let spawns : string array = [%bs.raw{|Object.keys(Game.spawns)|}]

(* This function iterates over all my units, trying to give them tasks *)
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

(* This function iterates over all of my spawns, trying to give them units to spawn *)
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

(* Baseline loop code. Calls all subfunctions*)
let run () : unit =
  ignore (iterateSpawns());
  ignore (iterateCreeps());
  doWatcher("")

let runEachTick : unit = run()
