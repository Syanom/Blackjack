require_relative 'player'

# Represents Dealer in game
class Dealer < Player
  def make_turn
    case hand.count_points
    when 1..17
      hand.cards.length < 3 ? :pull : :open
    else
      :open
    end
  end
end
