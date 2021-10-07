require_relative 'hand'

# Represents Player in game
class Player
  def initialize
    @hand = Hand.new
  end
end
