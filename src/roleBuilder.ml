open BaseTypes
open Creep
open HelperFunctions
open RoomObject
open ConstantConv

let runCreep(creep : creep) : unit =
  let carryCap = get_carry creep in
  let load = get_load creep in
  let currentRoom = get_room creep in
  if load < carryCap then
    let energySources = find currentRoom FIND_SOURCES_ACTIVE in
    let chosenSource  = get_closest creep energySources in
    (if (harvest creep (chosenSource) = (toNumResult ERR_NOT_IN_RANGE)) then
       moveTo creep chosenSource)
  else
    (let constructSites = find currentRoom FIND_MY_CONSTRUCTION_SITES in
     if (Array.length constructSites)  != 0
     then
       (let chosenSite  = Array.get constructSites 0 in
        if (build creep chosenSite = toNumResult ERR_NOT_IN_RANGE)
        then
           moveTo creep chosenSite)
     else
       RoleHarvester.runCreep(creep))
