require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'
require_relative 'round'
require_relative 'game'
require_relative 'interface'

game = Game.new(50, 10)
game.play
