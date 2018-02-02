'use strict'

# TODO: allow a 5th param 'initial' which is an object to fill in with results
# in case they want to specify all properties on their options object up front
# and allow cli parsing to alter the values.

module.exports = (options, aliases, args = process.argv, slice = 2) ->

  # let's do the slicing upfront because we may copy it for `original`
  args = args.slice slice

  # check for '$words' aliases in args and replace them
  if aliases?.$words?
    # remember the original args
    original = args.slice()
    words = aliases.$words
    # swap in all "word" aliases
    args[index] = words[arg] for arg,index in args when words[arg]?

  # finally, use nopt to get parsed options
  parsed = require('nopt')(options, aliases, args, 0)

  # set our "original" array from before we altered the words
  if original? then parsed.argv.original = original

  return parsed
