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
  match Array.length creeps with
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
    let body = [|WORK; CARRY; MOVE; MOVE|] in
    let spawnString = (Array.get spawns i) in
    let spawn = getSpawn (spawnString) in
    let room = getRoomFromSpawn spawn in
    let structures = find room FIND_MY_STRUCTURES in
    let isTower (ro : roomObject) : bool =
      match get_struct_type ro with
      | STRUCTURE_TOWER     -> true;
      | _                   -> false
    in
    let towersArray = Array.filter isTower structures in
    let numTowers = Array.length towersArray in
    (if numTowers != 0 then
       (for i=0 to numTowers -1 do
          Tower.runTower(Array.get towersArray i)
        done));
    let energyAvailable = getEnergyInRoom room in
    let bodyCost = arraySum (Array.map bodyPartToCost body ) in
    (* roleToOne is a One Hot Converter function which maps an creep within
       a role array to 1 if it is r : role, or 0 otherwise. *)
    let roleToOne (r : role) (creep : creep)  : int =
      if (getRole creep) = r then
        1
      else
        0
    in
    if bodyCost <= energyAvailable
    then

      let harvesterLim = 10 in
      let upgraderLim = 5 in
      let builderLim = 10 in

      (*TODO: Add room specificity for creeps (currently not scaleable to more
        than one spawn  *)
      let harvesterIntArray = Array.map (roleToOne Harvester) realCreeps in
      let harvesterNum = arraySum harvesterIntArray in

      let upgraderIntArray  = Array.map (roleToOne Upgrader ) realCreeps in
      let upgraderNum  = arraySum upgraderIntArray in

      let builderIntArray   = Array.map (roleToOne Builder  ) realCreeps in
      let builderNum   = arraySum builderIntArray in

      let actualBody = createLargestTandemBody spawn body in
      let actualBodyCost = arraySum(Array.map bodyPartToCost actualBody) in

      if actualBodyCost <= energyAvailable then
        (
          (* TODO: Refactor into methods to be called *)
          if harvesterNum < harvesterLim then
            ((let largestBody = createLargestTandemBody spawn body in
              ignore (spawnCreepWithRole spawnString largestBody Harvester);
              Js.log "Spawning new harvester creep");)
          else
            (if upgraderNum < upgraderLim then
               (let largestBody = createLargestTandemBody spawn body in
                ignore (spawnCreepWithRole spawnString largestBody Upgrader);
                Js.log "Spawning new upgrader creep")
             else
             if builderNum < builderLim then
               (let largestBody = createLargestTandemBody spawn body in
                ignore (spawnCreepWithRole spawnString largestBody Builder);
                Js.log "Spawning new builder creep")  ))
  done

(* Baseline loop code. Calls all subfunctions*)
let run () : unit =
  ignore (iterateCreeps());
  ignore (iterateSpawns());
  ignore (doWatcher(""));
  (* This clears dead creeps from memory -> otherwise they take up space *)
  clearDeadCreepsFromMemory("")
(* Js.log("TICK") *)

(* Helper variable which calls run *)
let runEachTick : unit = run()
