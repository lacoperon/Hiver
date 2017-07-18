function spawnCreepHelper(spawnName, body) {
  Game.spawns[spawnName].createCreep(body);
}

exports.spawnCreepHelper = spawnCreepHelper;
