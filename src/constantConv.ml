exception NumNotOfType of int
exception StringNotOfType of string

type resultConst =
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

let toNumResult(sc : resultConst) : int =
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

let fromNumResult(i : int) : resultConst =
  match i with
|   0 -> OK                        ;
|  -1 -> ERR_NOT_OWNER             ;
|  -2 -> ERR_NO_PATH               ;
|  -3 -> ERR_NAME_EXISTS           ;
|  -4 -> ERR_BUSY                  ;
|  -5 -> ERR_NOT_FOUND             ;
|  -6 -> ERR_NOT_ENOUGH_ENERGY     ;
|  -7 -> ERR_INVALID_TARGET        ;
|  -8 -> ERR_FULL                  ;
|  -9 -> ERR_NOT_IN_RANGE          ;
| -10 -> ERR_INVALID_ARGS          ;
| -11 -> ERR_TIRED                 ;
| -12 -> ERR_NO_BODYPART           ;
(* |  -6 -> ERR_NOT_ENOUGH_EXTENSIONS ; UNUSED -> cannot tell difference*)
| -14 -> ERR_RCL_NOT_ENOUGH        ;
| -15 -> ERR_GCL_NOT_ENOUGH
| x   -> raise (NumNotOfType x)

type filterConst =
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


let toNumFilter(sc : filterConst) : int =
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
  | FIND_MINERALS                   -> 116

let fromNumFilter(i : int) : filterConst =
  match i with
  |   1 -> FIND_EXIT_TOP                    ;
  |   3 -> FIND_EXIT_RIGHT                  ;
  |   5 -> FIND_EXIT_BOTTOM                 ;
  |   7 -> FIND_EXIT_LEFT                   ;
  |  10 -> FIND_EXIT                        ;
  | 101 -> FIND_CREEPS                      ;
  | 102 -> FIND_MY_CREEPS                   ;
  | 103 -> FIND_HOSTILE_CREEPS              ;
  | 104 -> FIND_SOURCES_ACTIVE              ;
  | 105 -> FIND_SOURCES                     ;
  | 106 -> FIND_DROPPED_ENERGY              ;
  (* | 106 -> FIND_DROPPED_RESOURCES           ; UNUSED *)
  | 107 -> FIND_STRUCTURES                  ;
  | 108 -> FIND_MY_STRUCTURES               ;
  | 109 -> FIND_HOSTILE_STRUCTURES          ;
  | 110 -> FIND_FLAGS                       ;
  | 111 -> FIND_CONSTRUCTION_SITES          ;
  | 112 -> FIND_MY_SPAWNS                   ;
  | 113 -> FIND_HOSTILE_SPAWNS              ;
  | 114 -> FIND_MY_CONSTRUCTION_SITES       ;
  | 115 -> FIND_HOSTILE_CONSTRUCTION_SITES  ;
  | 116 -> FIND_MINERALS                    ;
  | x   -> raise (NumNotOfType x)

type structureConst =
  | STRUCTURE_SPAWN
  | STRUCTURE_EXTENSION
  | STRUCTURE_ROAD
  | STRUCTURE_WALL
  | STRUCTURE_RAMPART
  | STRUCTURE_KEEPER_LAIR
  | STRUCTURE_PORTAL
  | STRUCTURE_CONTROLLER
  | STRUCTURE_LINK
  | STRUCTURE_STORAGE
  | STRUCTURE_TOWER
  | STRUCTURE_OBSERVER
  | STRUCTURE_POWER_BANK
  | STRUCTURE_POWER_SPAWN
  | STRUCTURE_EXTRACTOR
  | STRUCTURE_LAB
  | STRUCTURE_TERMINAL
  | STRUCTURE_CONTAINER

let toStringStructure (sc : structureConst) =
  match sc with
| STRUCTURE_SPAWN       -> "spawn";
| STRUCTURE_EXTENSION   -> "extension";
| STRUCTURE_ROAD        -> "road";
| STRUCTURE_WALL        -> "constructedWall";
| STRUCTURE_RAMPART     -> "rampart";
| STRUCTURE_KEEPER_LAIR -> "keeperLair";
| STRUCTURE_PORTAL      -> "portal";
| STRUCTURE_CONTROLLER  -> "controller";
| STRUCTURE_LINK        -> "link";
| STRUCTURE_STORAGE     -> "storage";
| STRUCTURE_TOWER       -> "tower";
| STRUCTURE_OBSERVER    -> "observer";
| STRUCTURE_POWER_BANK  -> "powerBank";
| STRUCTURE_POWER_SPAWN -> "powerSpawn";
| STRUCTURE_EXTRACTOR   -> "extractor";
| STRUCTURE_LAB         -> "lab";
| STRUCTURE_TERMINAL    -> "terminal";
| STRUCTURE_CONTAINER   -> "container"

let fromStringStructure (sc : string) : structureConst =
  match sc with
  | "spawn"           -> STRUCTURE_SPAWN;
  | "extension"       -> STRUCTURE_EXTENSION;
  | "road"            -> STRUCTURE_ROAD;
  | "constructedWall" -> STRUCTURE_WALL;
  | "rampart"         -> STRUCTURE_RAMPART;
  | "keeperLair"      -> STRUCTURE_KEEPER_LAIR;
  | "portal"          -> STRUCTURE_PORTAL;
  | "controller"      -> STRUCTURE_CONTROLLER;
  | "link"            -> STRUCTURE_LINK;
  | "storage"         -> STRUCTURE_STORAGE;
  | "tower"           -> STRUCTURE_TOWER;
  | "observer"        -> STRUCTURE_OBSERVER;
  | "powerBank"       -> STRUCTURE_POWER_BANK;
  | "powerSpawn"      -> STRUCTURE_POWER_SPAWN;
  | "extractor"       -> STRUCTURE_EXTRACTOR;
  | "lab"             -> STRUCTURE_LAB;
  | "terminal"        -> STRUCTURE_TERMINAL;
  | "container"       -> STRUCTURE_CONTAINER;
  | x                 -> raise(StringNotOfType x)
