require 'chai'
require 'should'
require 'through'
util = require 'util'

Random = require 'random-js'
fs = require 'fs'


myFile = fs.createWriteStream('e2e.out', flags: 'a' )
process.stdin.pipe(myFile)

console.log = (d) ->
  myFile.write(util.format(d) + '\n')
  process.stdout.write(util.format(d) + '\n')

describe "Game Seeded",  ->
  beforeEach ->
    # console.log "load module"
    @subject = require('../game')
    # console.log "get engine"
    # console.log Random, true
    @engine = Random.engines.mt19937()
    # console.log "ENGINE!!"
    # console.log @engine, true
    @engine.seed(1)

  it '10000 seeds', ->

    # console.log Random.engines, true
    for num in [0..10000]
      do (num) =>
        random = Random.integer(0, 1000000)(engine)
        new @subject.run(1)
