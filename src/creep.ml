open BaseTypes
open HelperFunctions

exception NotRoleString of string

external get_carry : creep -> int = "carryCapacity" [@@bs.get]
external get_load : creep -> int = "energy" [@@bs.get] [@@bs.scope "carry"]
external get_room : creep -> room = "room" [@@bs.get]
external get_closest : creep -> roomObject array -> roomObject = "findClosestByPath" [@@bs.send] [@@bs.scope "pos"]
external harvest : creep -> roomObject -> int = "harvest" [@@bs.send]
external moveTo : creep -> roomObject -> unit = "moveTo" [@@bs.send]
external getCreep: string -> creep = "" [@@bs.module "./supplemental", "Supplement"]
external getRoomFromCreep: creep -> room = "" [@@bs.module "./supplemental", "Supplement"]
external transfer : creep -> roomObject -> string -> int = "transfer" [@@bs.send]
external say : creep -> string -> unit = "say" [@@bs.send]


let setMemoryField(creepName : string) (memory : memoryField) : unit =
  match memory with
  | Working(x) ->
    defineMemoryHelper(creepName)("working")
      (match x with
       | true -> "true";
       | false-> "false");
  | Memory_Role(occupation) ->
    defineMemoryHelper(creepName)("role")(roleToString occupation)

(* THIS IS IMPORTANT -- KEEP IT UPDATED *)
let getRole(creep : creep) : role =
  match (getRoleHelper creep) with
  | "harvester" -> Harvester ;
  | "upgrader"  -> Upgrader ;
  | x           -> raise (NotRoleString(x))
