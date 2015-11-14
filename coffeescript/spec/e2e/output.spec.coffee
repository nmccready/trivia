require 'chai'
require 'should'
# require 'through'
util = require 'util'
Random = require 'random-js'
Promise = require 'bluebird'
fs = Promise.promisifyAll require 'fs'
del = require 'del'

fileName = 'e2e.out'
myFile = fs.createWriteStream(fileName)
process.stdin.pipe(myFile)
logStr = ''

e2eLogger = (toLog) ->
  myFile.write(util.format(toLog) + '\n')
  console.log toLog

strLogger = (toLog) ->
  logStr += toLog

describe "Game e2e Seeded",  ->
  after ->
    del fileName

  beforeEach ->
    @subject = require('../../game')(e2eLogger)
    @engine = Random.engines.mt19937()
    @engine.seed(1)

  it '10000 seeds', ->
    promises = []
    @subject.run(e2eLogger,1)

    # console.log Random.engines, true
    for num in [0..10000]
      do (num) =>
        random = Random.integer(0, 1000)(engine)
        @subject.run(strLogger,1)
        promises.push fd.readFileAsync(fileName).then (fileContents) ->
          fileContents.should.be logStr
    Promises.all promises
