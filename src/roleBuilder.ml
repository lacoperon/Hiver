open BaseTypes
open Creep
open HelperFunctions
open RoomObject
open ConstantConv

let runCreep(creep : creep) : unit =
  let carryCap = get_carry creep in
  let load = get_load creep in
  let currentRoom = get_room creep in
  let shouldMine = getIfShouldMine creep in

  if load = 0 then
    setMemoryField creep (Should_Mine(true)) ;

  if load = carryCap then
    setMemoryField creep (Should_Mine(false)) ;

  if shouldMine && load != carryCap then
    let energySources = find currentRoom FIND_SOURCES_ACTIVE in
    let chosenSource  = get_closest creep energySources in
    (if shouldMine then
       if (harvest creep (chosenSource) = (toNumResult ERR_NOT_IN_RANGE)) then
         (say creep "B_HARV";
          moveTo creep chosenSource))
  else
    (let constructSites = find currentRoom FIND_MY_CONSTRUCTION_SITES in
     if (Array.length constructSites)  != 0
     then
       (let chosenSite  = get_closest creep constructSites in
        (say creep "B_BUIL";
         if (build creep chosenSite = toNumResult ERR_NOT_IN_RANGE)
         then
           moveTo creep chosenSite))
     else
       (say creep "B_NOPE";
        RoleHarvester.runCreep(creep)))
