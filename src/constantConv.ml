type screepsResultConst =
  | OK
  | ERR_NOT_OWNER
  | ERR_NO_PATH
  | ERR_NAME_EXISTS
  | ERR_BUSY
  | ERR_NOT_FOUND
  | ERR_NOT_ENOUGH_ENERGY
  | ERR_INVALID_TARGET
  | ERR_FULL
  | ERR_NOT_IN_RANGE
  | ERR_INVALID_ARGS
  | ERR_TIRED
  | ERR_NO_BODYPART
  | ERR_NOT_ENOUGH_EXTENSIONS
  | ERR_RCL_NOT_ENOUGH
  | ERR_GCL_NOT_ENOUGH

let toNumResult(sc : screepsResultConst) : int =
  match sc with
  | OK                        ->   0;
  | ERR_NOT_OWNER             ->  -1;
  | ERR_NO_PATH               ->  -2;
  | ERR_NAME_EXISTS           ->  -3;
  | ERR_BUSY                  ->  -4;
  | ERR_NOT_FOUND             ->  -5;
  | ERR_NOT_ENOUGH_ENERGY     ->  -6;
  | ERR_INVALID_TARGET        ->  -7;
  | ERR_FULL                  ->  -8;
  | ERR_NOT_IN_RANGE          ->  -9;
  | ERR_INVALID_ARGS          -> -10;
  | ERR_TIRED                 -> -11;
  | ERR_NO_BODYPART           -> -12;
  | ERR_NOT_ENOUGH_EXTENSIONS ->  -6;
  | ERR_RCL_NOT_ENOUGH        -> -14;
  | ERR_GCL_NOT_ENOUGH        -> -15

type screepsFilterConst =
  | FIND_EXIT_TOP                   
  | FIND_EXIT_RIGHT
  | FIND_EXIT_BOTTOM
  | FIND_EXIT_LEFT
  | FIND_EXIT
  | FIND_CREEPS
  | FIND_MY_CREEPS
  | FIND_HOSTILE_CREEPS
  | FIND_SOURCES_ACTIVE
  | FIND_SOURCES
  | FIND_DROPPED_ENERGY
  | FIND_DROPPED_RESOURCES
  | FIND_STRUCTURES
  | FIND_MY_STRUCTURES
  | FIND_HOSTILE_STRUCTURES
  | FIND_FLAGS
  | FIND_CONSTRUCTION_SITES
  | FIND_MY_SPAWNS
  | FIND_HOSTILE_SPAWNS
  | FIND_MY_CONSTRUCTION_SITES
  | FIND_HOSTILE_CONSTRUCTION_SITES
  | FIND_MINERALS


let toNumFilter(sc : screepsFilterConst) =
match sc with
| FIND_EXIT_TOP                   ->   1;
| FIND_EXIT_RIGHT                 ->   3;
| FIND_EXIT_BOTTOM                ->   5;
| FIND_EXIT_LEFT                  ->   7;
| FIND_EXIT                       ->  10;
| FIND_CREEPS                     -> 101;
| FIND_MY_CREEPS                  -> 102;
| FIND_HOSTILE_CREEPS             -> 103;
| FIND_SOURCES_ACTIVE             -> 104;
| FIND_SOURCES                    -> 105;
| FIND_DROPPED_ENERGY             -> 106;
| FIND_DROPPED_RESOURCES          -> 106;
| FIND_STRUCTURES                 -> 107;
| FIND_MY_STRUCTURES              -> 108;
| FIND_HOSTILE_STRUCTURES         -> 109;
| FIND_FLAGS                      -> 110;
| FIND_CONSTRUCTION_SITES         -> 111;
| FIND_MY_SPAWNS                  -> 112;
| FIND_HOSTILE_SPAWNS             -> 113;
| FIND_MY_CONSTRUCTION_SITES      -> 114;
| FIND_HOSTILE_CONSTRUCTION_SITES -> 115;
| FIND_MINERALS                   -> 116;
