// Generated by BUCKLESCRIPT VERSION 1.8.1, PLEASE EDIT WITH CARE
'use strict';

var Caml_array    = require("bs-platform/lib/js/caml_array.js");
var RoomObject    = require("./roomObject.js");
var ConstantConv  = require("./constantConv.js");
var RoleHarvester = require("./roleHarvester.js");

function runCreep(creep) {
  var carryCap = creep.carryCapacity;
  var load = creep.carry.energy;
  var currentRoom = creep.room;
  if (load < carryCap) {
    var energySources = RoomObject.find(currentRoom, /* FIND_SOURCES_ACTIVE */8);
    var chosenSource = creep.pos.findClosestByPath(energySources);
    if (creep.harvest(chosenSource) === ConstantConv.toNumResult(/* ERR_NOT_IN_RANGE */9)) {
      creep.moveTo(chosenSource);
      return /* () */0;
    } else {
      return 0;
    }
  } else {
    var constructSites = RoomObject.find(currentRoom, /* FIND_MY_CONSTRUCTION_SITES */19);
    if (constructSites.length !== 0) {
      var chosenSite = Caml_array.caml_array_get(constructSites, 0);
      if (creep.build(chosenSite) === ConstantConv.toNumResult(/* ERR_NOT_IN_RANGE */9)) {
        creep.moveTo(chosenSite);
        return /* () */0;
      } else {
        return 0;
      }
    } else {
      return RoleHarvester.runCreep(creep);
    }
  }
}

exports.runCreep = runCreep;
/* RoleHarvester Not a pure module */