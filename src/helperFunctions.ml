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
external defineMemoryHelper : string -> string -> string -> unit = "" [@@bs.module "./supplemental", "Supplement"]

(* Using the 'Getter' provided by BuckleScript *)
external getStructureTypeHelper : roomObject -> string = "structureType" [@@bs.get]
external getRoleHelper : creep -> string = "role" [@@bs.get] [@@bs.scope "memory"]
external findHelper : room -> int -> roomObject array = "find" [@@bs.send]
