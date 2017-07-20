/* NOTE: This is the only file in this folder not transpiled by BUCKLESCRIPT.
  Still though, you should handle with care, although this will be more readable
  -@lacoperon */

function spawnCreepHelper(spawnName, body) {
  Game.spawns[spawnName].createCreep(body);
}

function defineMemoryHelper(creepName, fieldName, value) {
  Game.creeps[creepName].memory[fieldName] = value;
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

exports.spawnCreepHelper = spawnCreepHelper;
exports.defineMemoryHelper = defineMemoryHelper;
exports.doWatcher = doWatcher;
exports.getCreep = getCreep;
exports.getCreepEnergy = getCreepEnergy;
exports.getRoom = getRoom;
exports.spawnCreepWithMemoryHelper = spawnCreepWithMemoryHelper;
exports.getRoomfromSpawn = getRoomfromSpawn;
exports.getSpawn = getSpawn;
