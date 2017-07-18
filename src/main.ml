let creeps : string array = [%bs.raw{|Object.keys(Game.creeps)|}]
let creepsArray = creeps
(* let creepsObj : *)
let spawns : string array = [%bs.raw{|Object.keys(Game.spawns)|}]
let spawnsArray : string array = spawns

type bodyPart =
  | MOVE
  | WORK
  | CARRY
  | ATTACK
  | RANGED_ATTACK
  | HEAL
  | TOUGH
  | CLAIM


external spawnCreepHelper : string -> string array -> unit = "" [@@bs.module "./supplemental", "Supplement"]

let bodyPartToString(part : bodyPart) : string =
  match part with
  | MOVE -> "move" ;
  | WORK -> "work" ;
  | ATTACK -> "attack" ;
  | CARRY -> "carry" ;
  | RANGED_ATTACK -> "ranged_attack" ;
  | TOUGH -> "tough" ;
  | HEAL -> "heal" ;
  | CLAIM -> "claim"

let bodyPartToCost(part : bodyPart) : int =
  match part with
  | MOVE -> 50;
  | WORK -> 100;
  | ATTACK -> 80;
  | CARRY -> 50;
  | HEAL -> 250;
  | RANGED_ATTACK -> 150;
  | TOUGH -> 10;
  | CLAIM -> 600

let spawnCreep(spawn : string) (body : bodyPart array) : unit =
  spawnCreepHelper (spawn) (Array.map bodyPartToString body) ;
  Js.log("Spawning a new creep!")


type roomPosition =
  {
    x : int;
    y : int;
    roomName : string
  }





let iterateCreeps () : unit =
  match Array.length creeps  with
  | 0 -> Js.log("There are no creeps to iterate over") ;
  | x -> Js.log("There are " ^ (string_of_int x) ^ " creeps currently") ;

for i=0 to Array.length creeps - 1 do
  (* Js.log(Array.get creeps i) *)
  Js.log("One is named " ^ Array.get creeps i)
done

let iterateSpawns () : unit =
  match Array.length spawns with
  | 0 -> Js.log("There are no spawns to iterate over (should be untrue)") ;
  | x -> Js.log("There are " ^ (string_of_int x) ^ " spawns currently") ;

    for i=0 to Array.length spawns - 1 do
      Js.log("One is named " ^ Array.get spawns i);
      let body = [|WORK; CARRY; MOVE; MOVE|] in
      spawnCreep(Array.get spawns i) body
    done

(* external createCreep : (string, string array) -> unit =
  "" [@bs.module "Game"] [@bs.scope spawns] [] *)




let run () : unit =
  ignore (let time : int = [%bs.raw{|Date.now()|}] in Js.log(time)) ;
  ignore (iterateSpawns());
  iterateCreeps()
  (* spawnCreep() *)

let runEachTick : unit = run()
