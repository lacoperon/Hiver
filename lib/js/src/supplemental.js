/* NOTE: This is the only file in this folder not transpiled by BUCKLESCRIPT.
  Still though, you should handle with care, although this will be more readable
  -@lacoperon */

function spawnCreepHelper(spawnName, body) {
  Game.spawns[spawnName].createCreep(body);
}

function defineMemoryHelper(creepName, fieldName, value) {
  Game.creeps[creepName].memory[fieldName] = value;
}

exports.spawnCreepHelper = spawnCreepHelper;
exports.defineMemoryHelper = defineMemoryHelper;
