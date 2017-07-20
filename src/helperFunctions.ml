open BaseTypes

let arrayFilter (filter : 'a -> bool) (array : 'a array) : 'a array =
  let list = Array.to_list array in
  let filteredList = List.filter filter list in
  Array.of_list filteredList


let rec arraySumRecursive (numArray : int array) (currentSum : int) (currentIndex : int) : int =
  if Array.length numArray = currentIndex then currentSum
  else arraySumRecursive(numArray)(currentSum + Array.get numArray currentIndex)(currentIndex+1)
(* For convenience *)
let arraySum (numArray : int array) : int =
  arraySumRecursive(numArray)(0)(0)

external spawnCreepHelper : string -> string array -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external spawnCreepWithMemoryHelper : string -> string array -> string array -> int = "" [@@bs.module "./supplemental", "Supplement"]
external doWatcher : string -> unit = "" [@@bs.module "./supplemental", "Supplement"]
external getStructureTypeHelper : roomObject -> string = "structureType" [@@bs.get]
external findHelper : room -> int -> roomObject array = "find" [@@bs.send]
external defineMemoryHelper : string -> string -> string -> unit = "" [@@bs.module "./supplemental", "Supplement"]

let setMemoryField(creepName : string) (memory : memoryField) : unit =
  match memory with
  | Working(x) ->
    defineMemoryHelper(creepName)("working")
      (match x with
       | true -> "true";
       | false-> "false");
  | Memory_Role(occupation) ->
    defineMemoryHelper(creepName)("role")(roleToString occupation)
