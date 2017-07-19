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

function getSources(creep) {
  return creep.room.find(FIND_SOURCES);
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

exports.spawnCreepHelper = spawnCreepHelper;
exports.defineMemoryHelper = defineMemoryHelper;
exports.doWatcher = doWatcher;
exports.getCreep = getCreep;
exports.getCreepEnergy = getCreepEnergy;
exports.getSources = getSources;
exports.getRoom = getRoom;
