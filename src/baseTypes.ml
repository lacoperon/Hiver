(* These types are 'placeholders' I made in OCaml, allowing me to delineate
   what 'is' and 'is not' a member of the type.

   Given that converting a JS Object into OCaml requires me to accept a loss of
   generality (IE no function overloading, no null checks, etc.), I can't convert
   these objects into 'true' OCaml, so I just have types that help me keep track
   of exactly where they are and are not.

   IE I'm jerryrigging them so that OCaml will still typecheck that they are where
   they're meant to be, and not where they're not meant to be, despite their
   inability to be imported into OCaml *)

type creep =
  {
    isJustAJSObject : string;
  }

type spawn =
  {
    isJustAJSObject : string;
  }

type roomObject =
  {
    isJustAJSObject : string;
  }

type room =
  {
    isJustAJSObject : string;
  }

(* These are the types of bodyParts in Screeps *)

type bodyPart =
  | MOVE
  | WORK
  | CARRY
  | ATTACK
  | RANGED_ATTACK
  | HEAL
  | TOUGH
  | CLAIM

(* Defines all possible roles I make available to Creeps *)
type role =
  | Harvester

let roleToString (role : role) =
  match role with
  | Harvester -> "harvester"

(* Defines all of the memory fields I allow to be set on creeps programmatically *)
type memoryField =
  | Working of bool
  | Memory_Role of role
