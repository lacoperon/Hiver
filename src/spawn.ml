open BaseTypes
open HelperFunctions
open ConstantConv

(* Function which returns spawn object from spawnName string *)
external getSpawn: string -> spawn = "" [@@bs.module "./supplemental", "Supplement"]

external getEnergyCapacity : spawn -> int = "energyCapacity" [@@bs.get]

(* Function which spawns a creep with a memory defined in mfa : memoryField *)
(* TODO: Change mfa to memoryField array option, to make it more generalizable *)
let spawnCreepWithRole(spawn : string) (body : bodyPart array) (r : role) : int =
  spawnCreepWithMemoryHelper(spawn)(Array.map bodyPartToString body)([|"role";
                                                                       (match r with
                                                                        | Harvester -> "harvester";
                                                                        | Upgrader  -> "upgrader";
                                                                        | Builder   -> "builder")|])

(* Creates the largest 'tandem repeat' sequence of the bodyPart Array given,
   allowing for the most powerful creeps possible to spawn at each given point*)
let createLargestTandemBody(spawn : spawn)(body : bodyPart array) : bodyPart array =
  let spawnEnergy = getEnergyCapacity spawn in
  let bodyCost = arraySum (Array.map bodyPartToCost body) in
  if spawnEnergy > bodyCost then
    (
      let rec createLargestTandemBodyRec(spawnEnergyRemaining : int) (bodyUnit : bodyPart list) (currentBody : bodyPart list) : bodyPart array =
        if spawnEnergyRemaining < bodyCost then
          Array.of_list currentBody
        else
          createLargestTandemBodyRec(spawnEnergyRemaining - bodyCost) (bodyUnit)(bodyUnit @ currentBody)
      in
      createLargestTandemBodyRec(spawnEnergy)(Array.to_list body)([])
    )
  else
    (Js.log("Base body is too large");
     body)
