let creeps : string array = [%bs.raw{|console.log({})|}]

let run () : unit =
Js.log("TICK") ;
Js.log(creeps)

let doRun : unit = run()
