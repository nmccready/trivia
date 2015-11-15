expect = require('chai').expect
require 'should'
# require 'through'
util = require 'util'
Random = require 'random-js'
Promise = require 'bluebird'
fs = Promise.promisifyAll require 'fs'
del = require 'del'
seedrandom = require 'seedrandom'
mkdirp = require 'mkdirp'

FIX_SEED = 100
NUM_RUNS = 100
rndNumGen = seedrandom(FIX_SEED)
logStr = ''

savePath = "spec/e2e/randomResults"
_isBacked = false

mkdirp.sync savePath

muteLogger = ->

genFileName = (num) ->
  fName = "#{savePath}/e2e_#{num}.out"
  # console.log fName
  fName

createFileLogger = (fileName) ->
  myFile = fs.createWriteStream fileName,
    flags: 'w'
    highWaterMark: 100000000000000000
  myFile.setMaxListeners(10000000)

  myFile.on 'error', (err) ->
    console.error(err)
  myFile.on 'end', ->
    console.log "end: #{fileName}"
  myFile.on 'close', ->
    console.log "close: #{fileName}"


  e2eLogger = (toLog) ->
    if !_isBacked
      ok = myFile.write(util.format(toLog) + '\n')
    if !ok or _isBacked
      console.log "node stream buffer backed up" unless _isBacked
      _isBacked = true

      myFile.once 'drain', (err) =>
        _isBacked = false
        console.log "draining/resume"
        @(toLog)


  logger: e2eLogger
  fileStream: myFile

strLogger = (toLog) ->
  logStr += toLog


describe "Game e2e Seeded",  ->
  # after ->
  #   del fileName

  before ->
    @subject = new require('../../game')(muteLogger)
    console.log "Generating Seed Files"
    runNum = 0
    while(runNum <= NUM_RUNS)
      runNum += 1
      if(!_isBacked)
        number = rndNumGen()
        fileObj = createFileLogger genFileName(number)
        @subject.run(fileObj.logger,number)
        fileObj.fileStream.end()
      else
        console.log "backed"
      # delete fileObj.fileStream
      # delete fileObj.logger
      process.nextTick()
      console.log "run: #{runNum}"

  it "#{NUM_RUNS} seed runs", ->
  #   @subject.run(e2eLogger,1)
  #
  #   # console.log Random.engines, true
  #  eachSeed (num) =>
  #       @subject.run(strLogger,rndNumGen())
  #       fileContents = fs.readFileSync(fileName)
  #       expect(String(fileContents)).to.be.eql logStr
  #       logStr = ''
