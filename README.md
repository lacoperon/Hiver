#Hiver

Hiver is @lacoperon 's implementation of an AI for the programming game Screeps [link]
in OCaml, transpiled to Javascript through Bucklescript [link].

To install dependencies, simply run `npm install`, and make sure you've also
installed `OCaml` (IE `sudo apt-get install ocaml`) beforehand.

To build from `./src/*.ml` to `./deploy/main.js` (They're bundled together
via `webpack`), run `npm run build`. To deploy to the screeps server, setup
your own Gruntfile.js (based off of my `Gruntfile.example.js`), and then run
`grunt screeps`.

All `ml` files within `./src` are transpiled by Bucklescript into the `./lib/js/src` directory, and then all of those files are packed (with their
dependencies) into a `main.js` file within `./deploy` via `webpack`.

In the future, I'll be adding more functional accessibility between OCaml,
via the Bucklescript bindings, and the Screeps API.

The way I have settled on doing the access thus far (IE using `bs.raw`) is
potentially not the most type-safe way to do it (I could use a different method,
but that would require documenting every single type within the Screeps API down
from global objects like `Game`, and I don't have time for that alone. It would
also be a massive waste of time if nobody else wants to write their AI in OCaml).

Quick List:
  * `grunt`
  * `grunt-screeps'
  * `webpack`
  * `Bucklescript`
  * I think that's it, for now

//TODO: Add dependencies / other peoples' work to thank / more detailed deploy instructions
