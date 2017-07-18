# Hiver

Hiver is [lacoperon](https://www.github.com/lacoperon "GitHub Profile")'s implementation of an AI for the programming game [Screeps](https://www.screeps.com "Screeps")
in **OCaml**, transpiled to **Javascript** through [**Bucklescript**](http://bucklescript.github.io/bucklescript/Manual.html "Bucklescript") (which, by the way, is brilliant. You should check it out!).

**NOTE**: Implementing my AI in OCaml (when Screeps is a JS-based game) is impractical.
And using things like `bs.raw` removes the type-safety that would make OCaml practical and nice.
People before me have made the (sensible) choice of settling on TypeScript. I wanted to do something
more ambitious / weird. So, with that disclaimer out of the way, here's what I did (slash am doing).

To install dependencies, simply run `npm install`, and make sure you've also
installed OCaml   (IE `sudo apt-get install ocaml`) beforehand.

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



Quick List of Modules/Tools Used:
  * `grunt`
  * `grunt-screeps`
  * `webpack`
  * `Bucklescript`
  * `screeps-multimeter`(which saved me from having to launch the game GUI to see if my code has runtime JS errors.)

I currently use a whole bunch of supplemental Screeps interface functions I defined
within `./lib/js/src/supplemental.js`, to make working with the OCaml functions easier.
(IE Object-Oriented OCaml seems like something of a clusterfuck, and I don't want to deal with that
every time I need to call a function which is four properties down of the global Game Object if I don't have to).

T

//TODO: Add dependencies / other peoples' work to thank / more detailed deploy instructions
