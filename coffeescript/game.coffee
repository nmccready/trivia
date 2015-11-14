Random = require 'random-js'

Game = (logger = console.log) ->
  players = new Array()
  places = new Array(6)
  purses = new Array(6)
  inPenaltyBox = new Array(6)
  popQuestions = new Array()
  scienceQuestions = new Array()
  sportsQuestions = new Array()
  rockQuestions = new Array()
  currentPlayer = 0
  isGettingOutOfPenaltyBox = false
  didPlayerWin = ->
    (purses[currentPlayer] isnt 6)

  currentCategory = ->
    return "Pop"  if places[currentPlayer] is 0
    return "Pop"  if places[currentPlayer] is 4
    return "Pop"  if places[currentPlayer] is 8
    return "Science"  if places[currentPlayer] is 1
    return "Science"  if places[currentPlayer] is 5
    return "Science"  if places[currentPlayer] is 9
    return "Sports"  if places[currentPlayer] is 2
    return "Sports"  if places[currentPlayer] is 6
    return "Sports"  if places[currentPlayer] is 10
    "Rock"

  @createRockQuestion = (index) ->
    "Rock Question " + index

  i = 0

  while i < 50
    popQuestions.push "Pop Question " + i
    scienceQuestions.push "Science Question " + i
    sportsQuestions.push "Sports Question " + i
    rockQuestions.push @createRockQuestion(i)
    i++
  @isPlayable = (howManyPlayers) ->
    howManyPlayers >= 2

  @add = (playerName) ->
    players.push playerName
    places[@howManyPlayers() - 1] = 0
    purses[@howManyPlayers() - 1] = 0
    inPenaltyBox[@howManyPlayers() - 1] = false
    logger playerName + " was added"
    logger "They are player number " + players.length
    true

  @howManyPlayers = ->
    players.length

  askQuestion = ->
    logger popQuestions.shift()  if currentCategory() is "Pop"
    logger scienceQuestions.shift()  if currentCategory() is "Science"
    logger sportsQuestions.shift()  if currentCategory() is "Sports"
    logger rockQuestions.shift()  if currentCategory() is "Rock"

  @roll = (roll) ->
    logger players[currentPlayer] + " is the current player"
    logger "They have rolled a " + roll
    if inPenaltyBox[currentPlayer]
      unless roll % 2 is 0
        isGettingOutOfPenaltyBox = true
        logger players[currentPlayer] + " is getting out of the penalty box"
        places[currentPlayer] = places[currentPlayer] + roll
        places[currentPlayer] = places[currentPlayer] - 12  if places[currentPlayer] > 11
        logger players[currentPlayer] + "'s new location is " + places[currentPlayer]
        logger "The category is " + currentCategory()
        askQuestion()
      else
        logger players[currentPlayer] + " is not getting out of the penalty box"
        isGettingOutOfPenaltyBox = false
    else
      places[currentPlayer] = places[currentPlayer] + roll
      places[currentPlayer] = places[currentPlayer] - 12  if places[currentPlayer] > 11
      logger players[currentPlayer] + "'s new location is " + places[currentPlayer]
      logger "The category is " + currentCategory()
      askQuestion()

  @wasCorrectlyAnswered = ->
    if inPenaltyBox[currentPlayer]
      if isGettingOutOfPenaltyBox
        logger "Answer was correct!!!!"
        purses[currentPlayer] += 1
        logger players[currentPlayer] + " now has " + purses[currentPlayer] + " Gold Coins."
        winner = didPlayerWin()
        currentPlayer += 1
        currentPlayer = 0  if currentPlayer is players.length
        winner
      else
        currentPlayer += 1
        currentPlayer = 0  if currentPlayer is players.length
        true
    else
      logger "Answer was correct!!!!"
      purses[currentPlayer] += 1
      logger players[currentPlayer] + " now has " + purses[currentPlayer] + " Gold Coins."
      winner = didPlayerWin()
      currentPlayer += 1
      currentPlayer = 0  if currentPlayer is players.length
      winner

  @wrongAnswer = ->
    logger "Question was incorrectly answered"
    logger players[currentPlayer] + " was sent to the penalty box"
    inPenaltyBox[currentPlayer] = true
    currentPlayer += 1
    currentPlayer = 0  if currentPlayer is players.length
    true

  @

run = (logger = console.log, seed = 0, engine = Random.engines.mt19937()) ->
  engine.seed(seed)

  notAWinner = false
  game = new Game(logger)
  game.add "Chet"
  game.add "Pat"
  game.add "Sue"
  loop
    game.roll Math.floor(Random.integer(0, 1000)(engine) * 6) + 1
    if Math.floor(Math.random() * 10) is 7
      notAWinner = game.wrongAnswer()
    else
      notAWinner = game.wasCorrectlyAnswered()
    break unless notAWinner

module.exports = (logger = console.log) ->
  run(logger)
  Game:Game
  run:run
