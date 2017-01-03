assert = require 'assert'
wopt = require '../../lib'

describe 'test wopt', ->

  it 'should handle empty', ->
    # must specify the argv so it doesn't use the one initiating testing
    input = [ null, null, ['node', 'something.js'], null ]
    answer =
      argv:
        original: []
        cooked  : []
        remain  : []

    output = wopt.apply null, input
    assert.deepEqual output, answer

  it 'should handle usual options and aliases', ->

    input = [
      {
        version: Boolean
        help   : Boolean
      }
      {
        v: '--version'
        h: '--help'
        '?': '--help'
      }
      ['node', 'something.js', '--version', '--help']
      null
    ]
    answer =
      version: true
      help   : true
      argv:
        original: ['--version', '--help']
        cooked  : ['--version', '--help']
        remain  : []

    output = wopt.apply null, input
    assert.deepEqual output, answer

  it 'should handle usual options and aliases (2)', ->

    input = [
      {
        version: Boolean
        help   : Boolean
      }
      {
        v: '--version'
        h: '--help'
        '?': '--help'
      }
      ['node', 'something.js', '-v', '-h']
      null
    ]
    answer =
      version: true
      help   : true
      argv:
        original: ['-v', '-h']
        cooked  : ['--version', '--help']
        remain  : []

    output = wopt.apply null, input
    assert.deepEqual output, answer


  it 'shows nopt does NOT handle this on its own', ->

    input = [
      {
        version: Boolean
        help   : Boolean
      }
      {
        v: '--version'
        h: '--help'
        '?': '--help'
      }
      ['node', 'something.js', 'version', '?']
      null
    ]
    answer =
      argv:
        original: ['version', '?']
        cooked  : ['version', '?']
        remain  : ['version', '?']

    output = wopt.apply null, input
    assert.deepEqual output, answer


  it 'should handle $words aliases', ->
    # should replace 'version' with '--version'
    # and replace '?' with '--help'
    input = [
      {
        version: Boolean
        help   : Boolean
      }
      {
        v: '--version'
        h: '--help'
        $words:
          version: '--version'
          '?': '--help'
      }
      ['node', 'something.js', 'version', '?']
      null
    ]
    answer =
      version: true
      help   : true
      argv:
        original: ['version', '?']
        cooked  : ['--version', '--help']
        remain  : []

    output = wopt.apply null, input
    assert.deepEqual output, answer

  it 'should handle $words aliases (with slice)', ->
    # should replace 'version' with '--version'
    # and replace '?' with '--help'
    input = [
      {
        version: Boolean
        help   : Boolean
      }
      {
        v: '--version'
        h: '--help'
        $words:
          version: '--version'
          '?': '--help'
      }
      ['node', 'something.js', 'version', '?']
      2
    ]
    answer =
      version: true
      help   : true
      argv:
        original: ['version', '?']
        cooked  : ['--version', '--help']
        remain  : []

    output = wopt.apply null, input
    assert.deepEqual output, answer

  it 'should handle $words aliases (with diff slice)', ->
    # should replace 'version' with '--version'
    # and replace '?' with '--help'
    input = [
      {
        version: Boolean
        help   : Boolean
      }
      {
        v: '--version'
        h: '--help'
        $words:
          version: '--version'
          '?': '--help'
      }
      ['something.js', 'version', '?']
      1
    ]
    answer =
      version: true
      help   : true
      argv:
        original: ['version', '?']
        cooked  : ['--version', '--help']
        remain  : []

    output = wopt.apply null, input
    assert.deepEqual output, answer
