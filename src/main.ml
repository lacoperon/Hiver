open BaseTypes
open ConstantConv
open HelperFunctions
open Room
open RoomObject
open Spawn
open Creep

(* Gets both creeps and spawns using raw JS code *)
let creeps : string array = [%bs.raw{|Object.keys(Game.creeps)|}]
let realCreeps : creep array = Array.map getCreep creeps
let spawns : string array = [%bs.raw{|Object.keys(Game.spawns)|}]

(* This function iterates over all my units, trying to give them tasks *)
let iterateCreeps () : unit =
  match Array.length creeps  with
  | 0 -> Js.log("There are no creeps to iterate over") ;
  | x -> () ;
    for i=0 to x - 1 do
      let creepName = Array.get creeps i in
      let creep = getCreep(creepName) in
      let creepRole = getRole creep in
      match creepRole with
      | Harvester -> RoleHarvester.runCreep(creep) ;
      | Upgrader  -> RoleUpgrader.runCreep(creep)  ;
      | Builder   -> RoleBuilder.runCreep(creep)
    done



(* This function iterates over all of my spawns, trying to give them units to spawn *)
let iterateSpawns () : unit =
  for i=0 to Array.length spawns - 1 do
    (* Js.log "hello"; GETS HERE*)
    let body = [|WORK; CARRY; MOVE; MOVE|] in
    let spawnString = (Array.get spawns i) in
    let spawn = getSpawn (spawnString) in
    let room = getRoomFromSpawn spawn in
    (* Js.log (find room FIND_MY_CONSTRUCTION_SITES); *)
    let energyAvailable = getEnergyInRoom room in
    let bodyCost = arraySum (Array.map bodyPartToCost body ) in
    let roleToOne (r : role) (creep : creep)  : int =
      if (getRole creep) = r then
        1
      else
        0
    in
    if bodyCost <= energyAvailable
    then
      (*TODO: Add room specificity for creeps (currently not scaleable to more
        than one spawn  *)
      let harvesterIntArray = Array.map (roleToOne Harvester) realCreeps in
      let harvesterNum = arraySum harvesterIntArray in

      let upgraderIntArray  = Array.map (roleToOne Upgrader ) realCreeps in
      let upgraderNum  = arraySum upgraderIntArray in

      let builderIntArray   = Array.map (roleToOne Builder  ) realCreeps in
      let builderNum   = arraySum builderIntArray in

      if harvesterNum > 3 && builderNum = 0 then
        (ignore (spawnCreepWithRole spawnString body Builder);
         Js.log "Spawning new builder creep")
      else
        (

          if harvesterNum > 4 && upgraderNum < 3
          then
            (ignore (spawnCreepWithRole spawnString body Upgrader);
             Js.log "Spawning new upgrader creep")
          else
            (ignore (spawnCreepWithRole spawnString body Harvester) ;
             Js.log("Spawning new harvester creep"))
        )
  done

(* Baseline loop code. Calls all subfunctions*)
let run () : unit =
  ignore (iterateCreeps());
  ignore (iterateSpawns());
  ignore (doWatcher(""));
  clearDeadCreepsFromMemory("")
(* Js.log("TICK") *)


let runEachTick : unit = run()
