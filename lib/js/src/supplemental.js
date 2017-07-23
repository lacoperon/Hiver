/* NOTE: This is the only file in this folder not transpiled by BUCKLESCRIPT.
  Still though, you should handle with care, although this will be more readable
  -@lacoperon */

function spawnCreepHelper(spawnName, body) {
  Game.spawns[spawnName].createCreep(body);
}

function defineMemoryHelper(creep, fieldName, value) {
  creep.memory[fieldName] = value;
}

function doWatcher(empty) {
  var watcher = require('./watch-client');
  watcher();
}

function getCreepEnergy(creepName) {
  return Game.creeps[creepName].carry.energy;
}

function getCreepCarryCapacity(creepName) {
  return Game.creeps[creepName].carryCapacity;
}

function getCreep(creepName) {
  return Game.creeps[creepName];
}

function getRoom(creep) {
  return creep.room;
}

function getRoomFromCreep(creep) {
  return creep.room;
}

function findInRoom(room, thing) {
  return room.find(thing);
}

function getRoomfromSpawn(spawn) {
  return spawn.room;
}

function getSpawn(spawnString) {
  return Game.spawns[spawnString];
}

function spawnCreepWithMemoryHelper(spawnstring, body, memoryArray) {
  memoryObject = {
    role : memoryArray[1]
  };
  Game.spawns[spawnstring].createCreep(body, null, memoryObject);
}

function clearDeadCreepsFromMemory(emptyString) {
  for(var i in Memory.creeps) {
      if(!Game.creeps[i]) {
          delete Memory.creeps[i];
      }
  }
}

function isAssignedSource(creep) {
  if(creep.memory.source) {
    return true;
  }
  return false;
}

function getObjectFromID(id) {
  return Game.getObjectById(id);
}

function getIfShouldMine(creep) {
  return (creep.memory.mining == "true");
}

function getRoomFromString(string) {
  return Game.rooms[string];
}

exports.spawnCreepHelper = spawnCreepHelper;
exports.defineMemoryHelper = defineMemoryHelper;
exports.doWatcher = doWatcher;
exports.getCreep = getCreep;
exports.getCreepEnergy = getCreepEnergy;
exports.getRoom = getRoom;
exports.spawnCreepWithMemoryHelper = spawnCreepWithMemoryHelper;
exports.getRoomfromSpawn = getRoomfromSpawn;
exports.getSpawn = getSpawn;
exports.clearDeadCreepsFromMemory = clearDeadCreepsFromMemory;
exports.isAssignedSource = isAssignedSource;
exports.getObjectFromID = getObjectFromID;
exports.getIfShouldMine = getIfShouldMine;
exports.getRoomFromString = getRoomFromString;
