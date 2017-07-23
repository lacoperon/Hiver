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
  if not (isAssignedSource creep)
  then
    (let energySources = find currentRoom FIND_SOURCES_ACTIVE in
     let chosenSource  = get_closest creep energySources in
     let chosenSourceID = getIDFromStructure chosenSource in
     setMemoryField(creep)(Memory_Source(chosenSourceID)))
  else
  if load = 0 then
    (setMemoryField(creep)(Should_Mine true) ;
     Js.log("Before error");
     let chosenSource  = getObjectFromID (getSourceFromMemory creep) in
     Js.log("After Error");
     if (harvest creep (chosenSource) = (toNumResult ERR_NOT_IN_RANGE)) then
       moveTo creep chosenSource)
  else
    (let chosenSource  = getObjectFromID (getSourceFromMemory creep) in
     let shouldMine = getIfShouldMine creep in
     if (load < carryCap && shouldMine ) then
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
