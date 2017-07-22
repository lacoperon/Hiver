open BaseTypes

module Array = struct
  include Array
  let filter (cond : 'a -> bool) (array : 'a array) =
    let list = Array.to_list array in
    let filteredList = List.filter cond list in
    Array.of_list filteredList
end

(* Recursive helper for arraySum *)
let rec arraySumRecursive (numArray : int array) (currentSum : int) (currentIndex : int) : int =
  if Array.length numArray = currentIndex then currentSum
  else arraySumRecursive(numArray)(currentSum + Array.get numArray currentIndex)(currentIndex+1)

(* Sums an array *)
let arraySum (numArray : int array) : int =
  arraySumRecursive(numArray)(0)(0)

(* Various helper functions used in other modules to embed JS functionality *)
external spawnCreepHelper : string -> string array -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external spawnCreepWithMemoryHelper : string -> string array -> string array -> int = "" [@@bs.module "./supplemental", "Supplement"]
external doWatcher : string -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external clearDeadCreepsFromMemory : string -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external defineMemoryHelper : creep -> string -> string -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external isAssignedSource : creep -> bool = "" [@@bs.module "./supplemental", "Supplemental"]
external getObjectFromID : string -> roomObject = "" [@@bs.module "./supplemental", "Supplemental"]
external getIfShouldMine : creep  -> bool = "" [@@bs.module "./supplemental", "Supplemental"]


(* Using the 'Getter' provided by BuckleScript *)
external getStructureTypeHelper : roomObject -> string = "structureType" [@@bs.get]
external getRoleHelper : creep -> string = "role" [@@bs.get] [@@bs.scope "memory"]
external findHelper : room -> int -> roomObject array = "find" [@@bs.send]
external gameNotify : string -> unit = "notify" [@@bs.val "Game"]
external getIDFromStructure : roomObject -> string = "id" [@@bs.get]
external getSourceFromMemory : creep -> string = "source" [@@bs.get] [@@bs.scope "memory"]
external getExtensionOrSpawnEnergy : roomObject -> int = "energy" [@@bs.get]
external getExtensionOrSpawnCapacity : roomObject -> int = "energyCapacity" [@@bs.get]

let setMemoryField(creep : creep) (memory : memoryField) : unit =
  match memory with
  | Working(x) ->
    defineMemoryHelper(creep)("working")
      (match x with
       | true -> "true";
       | false-> "false");
  | Memory_Role(occupation) ->
    defineMemoryHelper(creep)("role")(roleToString occupation)
  | Should_Mine(x) ->
    defineMemoryHelper(creep)("mining")
      (match x with
       | true -> "true";
       | false-> "false")
  | Should_Build(x)->
    defineMemoryHelper(creep)("building")
      (match x with
       | true -> "true";
       | false-> "false")
  | Memory_Source(roID) ->
    defineMemoryHelper(creep)("source")(roID)
