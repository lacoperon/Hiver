open BaseTypes
open HelperFunctions
open ConstantConv

(* Function which returns spawn object from spawnName string *)
external getSpawn: string -> spawn = "" [@@bs.module "./supplemental", "Supplement"]

(* Function which spawns a creep with a memory defined in mfa : memoryField *)
(* TODO: Change mfa to memoryField array option, to make it more generalizable *)
let spawnCreepWithRole(spawn : string) (body : bodyPart array) (r : role) : int =
  spawnCreepWithMemoryHelper(spawn)(Array.map bodyPartToString body)([|"role";
                                                                       (match r with
                                                                        | Harvester -> "harvester";
                                                                        | Upgrader  -> "upgrader";
                                                                        | Builder   -> "builder")|])
