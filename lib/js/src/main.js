/* This is an 'interface' file, which lets me satisfy Screeps' own internal
   required structure (so they can run it in their own V8 emulation), while also
   being able to import all of the BuckleScript-compiled code I actually want to
   use. This is NECESSARY for successful, functional deployment to the Screeps'
   server.   -@lacoperon */

var mainLoop = require('main_loop');

module.exports.loop = function () {
  mainLoop.run();
}
