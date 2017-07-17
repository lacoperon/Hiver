let creeps : string array = [%bs.raw{|Object.keys(Game.creeps)|}]
let creepsArray = creeps
let spawns : string array = [%bs.raw{|Object.keys(Game.spawns)|}]  (* Temporary Hard Coding *)
let spawnsArray : string array = spawns


type game
external game : game = "Game" [@@bs.val]


(* let spawnCreep : *)


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
      Js.log("One is named " ^ Array.get spawns i)
    done


let run () : unit =
  ignore (let time : int = [%bs.raw{|Date.now()|}] in Js.log(time)) ;
  ignore (iterateSpawns());
  iterateCreeps()

let runEachTick : unit = run()
