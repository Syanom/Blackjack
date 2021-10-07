require_relative 'dealer_hand'

# Represents Dealer in game
class Dealer
  def initialize
    @hand = DealerHand.new
  end
end
