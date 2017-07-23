open BaseTypes

external getRoomFromSpawn : spawn -> room = "room" [@@bs.get]
external getEnergyInRoom : room -> int = "energyAvailable" [@@bs.get]
external getRoomFromCreep : creep -> room = "room" [@@bs.get]
