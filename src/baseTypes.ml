

type creep =
  {
    carryCapacity : int;
    name : string;
  }

type spawn =
  {
    name : string;
  }

type roomObject =
  {
    id : string;
  }

type room =
  {
    name : string;
  }

type bodyPart =
  | MOVE
  | WORK
  | CARRY
  | ATTACK
  | RANGED_ATTACK
  | HEAL
  | TOUGH
  | CLAIM

(* Defines all possible roles available to Creeps *)
type role =
  | Harvester

let roleToString (role : role) =
  match role with
  | Harvester -> "harvester"

(* Defines all of the memory fields I allow to be set on creeps programmatically *)
type memoryField =
  | Working of bool
  | Memory_Role of role
