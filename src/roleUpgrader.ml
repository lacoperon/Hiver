(* TODO: Extract this code from iterateCreeps loop *)

open BaseTypes
open Creep
open ConstantConv
open RoomObject
open HelperFunctions

let runCreep(creep : creep) : unit =
  (* say creep "Upgrade"; *)
  let carryCap = get_carry creep in
  let load = get_load creep in
  let currentRoom = get_room creep in
  if load = 0 then
    (setMemoryField(creep)(Should_Mine true) ;
     let energySources = find currentRoom FIND_SOURCES_ACTIVE in
     let chosenSource  = Array.get energySources 1 in
     if (harvest creep (chosenSource) = (toNumResult ERR_NOT_IN_RANGE)) then
       moveTo creep chosenSource)
  else
    (let energySources = find currentRoom FIND_SOURCES_ACTIVE in
     let chosenSource  = Array.get energySources 1 in
     if (load < carryCap && ((getIfMining creep) = true) ) then
       (if (harvest creep (chosenSource) = (toNumResult ERR_NOT_IN_RANGE)) then
          moveTo creep chosenSource)
     else
       (setMemoryField(creep)(Should_Mine false) ;
        let structureArray = find currentRoom FIND_MY_STRUCTURES in
        let isSpawnOrExtension (ro : roomObject) : bool =
          match get_struct_type ro with
          | STRUCTURE_CONTROLLER  -> true;
          | _                     -> false
        in
        let spawnsAndExtensions =  Array.filter (isSpawnOrExtension) (structureArray)  in
        (* TODO: Add code which sets the destination structure randomly, and assigns
           it permanantly to the harvester creep *)
        let chosenStructure = Array.get spawnsAndExtensions 0 in
        ignore (transfer creep chosenStructure "energy") ;
        ignore(moveTo creep chosenStructure);
        () ) )
