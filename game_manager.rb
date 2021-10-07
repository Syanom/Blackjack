require_relative 'player'
require_relative 'dealer'
require_relative 'deck'

# Runs the game
class GameManager
  def initialize
    @deck = Deck.new
    @players = []
    @players << Player.new << Dealer.new
  end

  def start_game; end
end
