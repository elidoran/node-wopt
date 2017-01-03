# wopt
[![Build Status](https://travis-ci.org/elidoran/node-wopt.svg?branch=master)](https://travis-ci.org/elidoran/node-wopt)
[![Dependency Status](https://gemnasium.com/elidoran/node-wopt.png)](https://gemnasium.com/elidoran/node-wopt)
[![npm version](https://badge.fury.io/js/wopt.svg)](http://badge.fury.io/js/wopt)
[![Coverage Status](https://coveralls.io/repos/github/elidoran/node-wopt/badge.svg?branch=master)](https://coveralls.io/github/elidoran/node-wopt?branch=master)

Enhances nopt with ability to interpret words as options.

Word options are added by this package so I named it **wopt**.


## Install

```sh
npm install wopt --save
```


## Usage

This library wraps **nopt** so look at the [nopt README](https://www.npmjs.com/package/nopt) to understand how to use it.

Then, look here to see the extra functionality added by **wopt**.

```javascript
// we'll use this to specify the type of an option
var path = require('path')
  , wopt = require('wopt')
  , optionSpec = {
      // the usual spot for options
      version: Boolean,
      help   : Boolean,
      from   : [path, Array],
      to     : [path],
  }
  , aliases = {
    // the usual spot for aliases
    v: ['--version'],
    h: ['--help'],
    f: ['--from'],
    t: ['--to'],
    // and now the aliases allowed by wopt.
    // put them into their own object so they can be easily separated.
    $words: {
      version: '--version',
      help   : '--help',
      '?'    : '--help'
      from   : '--from',
      to     : '--to',
    }
  }
  , parsed = wopt(optionSpec, aliases, process.argv, 2)

// these commands would all produce the same result, shown below:
//   node myindex.js --from some/file --from another/file --to output/file
//   node myindex.js -f some/file -f another/file -t output/file
//*  node myindex.js from some/file from another/file to output/file

// resulting `parsed` object of the last one:
{
  from: [ 'some/file', 'another/file' ] // paths
  to  : 'output/file' // path
  argv: {
    original: [ // the original before this library changed the words
      'from', 'some/file', 'from', 'another/file', 'to', 'output/file'
    ],
    cooked: [
      '--from', 'some/file', '--from', 'another/file', '--to', 'output/file'
    ],
    remain: []
  }
}

// with the above options these alternatives are also available:
//   node myindex.js version
//   node myindex.js help
//   node myindex.js ?
```


## MIT License
