open BaseTypes
open HelperFunctions
open ConstantConv

(* Gets the structure type of a roomObject *)
let get_struct_type(r : roomObject) : structureConst =
  let structString = getStructureTypeHelper r in
  fromStringStructure structString

(* Finds all roomObjects in a room satisfying filterConst *)
let find(r : room) (f : filterConst) : roomObject array  =
  findHelper r (toNumFilter f)
