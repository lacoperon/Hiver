open BaseTypes
open HelperFunctions
open ConstantConv

(* Function which returns spawn object from spawnName string *)
external getSpawn: string -> spawn = "" [@@bs.module "./supplemental", "Supplement"]

(* Function which spawns a creep with a memory defined in mfa : memoryField *)
(* TODO: Change mfa to memoryField array option, to make it more generalizable *)
let spawnCreepWithMemory(spawn : string) (body : bodyPart array) (mfa : memoryField) : int =
  spawnCreepWithMemoryHelper(spawn)(Array.map bodyPartToString body)
    (match mfa with
     |   Memory_Role(role) -> ([|"role"; roleToString role|]);
     |   Working(x) -> ([|"working"; if x then "true" else "false"|]) )
