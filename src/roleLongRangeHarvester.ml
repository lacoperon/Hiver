(* TODO: Extract this code from iterateCreeps loop *)

open BaseTypes
open Creep
open ConstantConv
open RoomObject
open HelperFunctions

(*TODO: Add check that all spawns / extensions aren't full, else upgrader.

  Also maybe something about creep recycling after they're obsolete*)

let runCreep(creep : creep) : unit =
  (* say creep "Harvest" ; *)
  let carryCap = get_carry creep in
  let load = get_load creep in
  let assignedSourceID = "57ef9e7b86f108ae6e60f5e2" in
  if not (isAssignedSource creep)
  then
    (let room = getRoomFromCreep creep in
     setMemoryField(creep)(Memory_Source(assignedSourceID));
     setMemoryField(creep)(Homeroom(getRoomName room)));
  let roomString = getHomeroomFromMemory creep in
  let homeroom = getRoomFromString roomString in
  (if load = 0 then
     setMemoryField(creep)(Should_Mine(true)));
  (if load = carryCap then
     setMemoryField(creep)(Should_Mine(false)));
  let isMining = (getIfMining creep = "true") in
  if load < carryCap && isMining then
    let sourceID      = getSourceFromMemory creep in
    let chosenSource  = getObjectFromID sourceID in
    (if (harvest creep (chosenSource) = (toNumResult ERR_NOT_IN_RANGE)) then
       moveTo creep chosenSource)
  else
    (* TODO: Memoize structures (for a tick, or several) *)
    (let structureArray = find homeroom FIND_MY_STRUCTURES in
     let isSpawnOrExtension (ro : roomObject) : bool =
       match get_struct_type ro with
       | STRUCTURE_SPAWN     -> true;
       | STRUCTURE_EXTENSION -> true;
       | _                   -> false
     in
     let isNotFull (ro : roomObject) : bool =
       (let energy = getExtensionOrSpawnEnergy ro in
        let cap    = getExtensionOrSpawnCapacity ro in
        energy != cap )
     in
     let spawnsAndExtensions =  Array.filter (isSpawnOrExtension) (structureArray)  in
     let notFullSpawnsAndExtensions = Array.filter (isNotFull) (spawnsAndExtensions) in
     if (Array.length notFullSpawnsAndExtensions != 0) then
       (
         let chosenStructure = Array.get notFullSpawnsAndExtensions 0 in
         ignore (transfer creep chosenStructure "energy") ;
         ignore(moveTo creep chosenStructure) );
     ())
