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

let creepsArray : string array = [%bs.raw{|Object.keys(Game.creeps)|}]
let spawnsArray : string array = [%bs.raw{|Object.keys(Game.spawns)|}]
