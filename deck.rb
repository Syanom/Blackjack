require_relative 'card'

# Deck for the game
class Deck
  def initialize
    @cards = []
    Card.ranks.each do |rank|
      Card.suits.each { |suit| @cards << Card.new(rank, suit) }
    end
  end
end
