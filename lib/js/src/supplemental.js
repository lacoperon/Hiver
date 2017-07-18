function spawnCreepHelper(spawnName, body) {
  Game.spawns[spawnName].createCreep(body);
}

function defineMemoryHelper(creepName, fieldName, value) {
  Game.creeps[creepName].memory[fieldName] = value;
}

exports.spawnCreepHelper = spawnCreepHelper;
