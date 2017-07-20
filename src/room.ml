open BaseTypes

external getRoomFromSpawn : spawn -> room = "room" [@@bs.get]
external getEnergyInRoom : room -> int = "energyAvailable" [@@bs.get]
