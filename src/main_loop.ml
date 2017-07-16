let run () : unit =
Js.log("Deployment succeeded to Screeps Server") ;
Js.log("Hopefully this will successfully build") ;
external creeps : string array = ""[@@bs.module "Game"]
let creeps = creeps;
for i = 1 to 10 do
  Roleharvester.run(Array.get creeps i)
done
