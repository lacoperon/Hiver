(* TODO: Extract this code from iterateCreeps loop *)

open BaseTypes
open Creep
open ConstantConv
open RoomObject
open HelperFunctions

let runCreep(creep : creep) : unit =
  (* say creep "Harvest" ; *)
  let carryCap = get_carry creep in
  let load = get_load creep in
  let currentRoom = get_room creep in
  if not (isAssignedSource creep)
  then
    (let energySources = find currentRoom FIND_SOURCES_ACTIVE in
     let i  = Random.int (Array.length energySources) in
     let chosenSourceID = getIDFromStructure (Array.get energySources i) in
     setMemoryField(creep)(Memory_Source(chosenSourceID)));
  if load < carryCap then
    let sourceID      = getSourceFromMemory creep in
    let chosenSource  = getObjectFromID sourceID in
    (if (harvest creep (chosenSource) = (toNumResult ERR_NOT_IN_RANGE)) then
       moveTo creep chosenSource)
  else
    let structureArray = find currentRoom FIND_MY_STRUCTURES in
    let isSpawnOrExtension (ro : roomObject) : bool =
      match get_struct_type ro with
      | STRUCTURE_SPAWN     -> true;
      | STRUCTURE_EXTENSION -> true;
      | _                   -> false
    in
    let spawnsAndExtensions =  Array.filter (isSpawnOrExtension) (structureArray)  in
    (* TODO: Add code which sets the destination structure randomly, and assigns
       it permanantly to the harvester creep *)
    let chosenStructure = Array.get spawnsAndExtensions 0 in
    ignore (transfer creep chosenStructure "energy") ;
    ignore(moveTo creep chosenStructure);
    ()
