require_relative 'dealer_hand'

# Represents Dealer in game
class Dealer
  attr_accessor :hand

  def initialize
    @hand = DealerHand.new
  end

  def make_turn
    case hand.count_points
    when 1..17
      hand.cards.length < 3 ? :pull : :skip
    else
      :skip
    end
  end
end
