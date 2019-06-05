'use strict'

// TODO: allow a 5th param 'initial' which is an object to fill in with results
// in case they want to specify all properties on their options object up front
// and allow cli parsing to alter the values.
module.exports = function(options, aliases, argArray, slice) {

  // let's do the slicing upfront because we may copy it for `original`
  const args = (argArray || process.argv).slice(slice != null ? slice : 2)

  // we may not need this.
  let original = null

  // check for '$words' aliases in args and replace them
  if (aliases && aliases.$words) {

    // remember the original args
    original = args.slice()

    const words = aliases.$words

    for (const index in args) {

      const arg = args[index]

      if (words[arg]) {
        // swap in all "word" aliases
        args[index] = words[arg]
      }
    }
  }
  // finally, use nopt to get parsed options
  const parsed = require('nopt')(options, aliases, args, 0)

  // set our "original" array from before we altered the words
  if (original) {
    parsed.argv.original = original
  }

  return parsed
}
