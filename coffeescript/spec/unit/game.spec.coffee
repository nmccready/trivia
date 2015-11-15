require 'chai'
require 'should'

muteLogger = ->

describe "Game",  ->
  beforeEach ->
    @subject = new require('../../game')(muteLogger).Game(muteLogger)

  describe 'createRockQuestion', ->

  it "exists", ->
    @subject.should.be.ok

  describe 'plublic functions', ->
    beforeEach ->
      @players = [
        'nick'
        'jon'
      ]
    describe 'add', ->
      beforeEach ->
        # console.log @subject, true
      it 'exists', ->
        @subject.add.should.be.ok

      it 'pre add', ->
        @subject.howManyPlayers().should.be.eql 0

      it 'post add', ->
        @subject.howManyPlayers().should.be.eql 0
        @players.forEach (name) =>
          @subject.add name
        @subject.howManyPlayers().should.be.eql @players.length

      it 'returns', ->
        @subject.add().should.be.ok
