# Hiver

Hiver is [lacoperon](https://www.github.com/lacoperon "GitHub Profile")'s implementation of an AI for the programming game [Screeps](https://www.screeps.com "Screeps") in **OCaml**, transpiled to **Javascript** through [**Bucklescript**](http://bucklescript.github.io/bucklescript/Manual.html "Bucklescript") (which, by the way, is brilliant. You should check it out!).

My rationale behind doing this is that OCaml-transpiled Javascript is (depending on the measure) around 3x faster than regular Javascript. The Screeps game imposes CPU limits on players in the game, so execution time is at a premium. So, faster scripts --> faster execution --> profit (hopefully).

### Configuration

Replace `Gruntfile.example.js` with `Gruntfile.js`, in which your Screeps
username and password (and branch, if applicable) are filled out correctly.

Then, you should be good to go.

### Installation (for anyone who wants to try this out)
To install dependencies, simply run `npm install`, and to transpile + package
your ml code, run `npm run build`.

All `ml` files within `./src` are transpiled by Bucklescript into the `./lib/js/src` directory,
and then all of those files are packed (with their dependencies) into `./deploy/main.js` by webpack.

**Also note**: Functions that don't easily translate into OCaml (or that I wrote in the beginning of my time writing this project) are found in `lib/js/src/supplemental.js`, and these functions are referred to elsewhere (IE in my `ml` files) using the appropriate `[@@bs.send]` syntax described within the Bucklescript manual.

Quick List of Modules/Tools Used:
  * `grunt`
  * `grunt-screeps`
  * `webpack`
  * `Bucklescript`
  * `screeps-multimeter`(which saved me from having to launch the game GUI to see if my code has runtime JS errors.)


### Description of my AI Implementation

Each tick, the `run` function (within `main.ml`) is called, which in turn calls functions which iterates through my units (`iterateCreeps`, which has each creep do their respective role in the colony), my spawns (`iterateSpawns`, which sees if a given spawn can make a new unit), as well as garbage collects my memory `clearDeadCreepsFromMemory`, and provides me data I can see outside of the game window (`doWatcher`).

#### Creep Roles

My units ('creeps', in Screeps parlance) each have various roles:

* **Harvester** : harvests energy, and brings it to the spawn to make more units
* **Upgrader** : harvests/transports energy, and brings it to the Room Controller to 'level up' my room
* **Builder** : harvests/transports energy, and builds/repairs my structures with it

(*There are more to come, but this is it for now*.)

#### Spawn Logic

*To come later. Stay tuned, folks.*
