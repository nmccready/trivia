require 'chai'
require 'should'

describe "Game",  ->
  beforeEach ->
    #TODO: THIS IS NOT HOW YOU DO THINGS
    require('../game')
    @subject = global.Game()
  # it "should pass", ->
  #   expect(true).to.be true

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





describe "Your specs..." , ->
