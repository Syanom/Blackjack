require_relative 'player'

# Represents Dealer in game
class Dealer < Player
  NAMES = %w[Sara Mark Lizbeth Quinton Rayan Ivan Aizek Katrin Simon Fibi Irma
             Wilgelm Ashton].freeze

  def initialize
    super("#{NAMES.sample}(ai)")
  end

  def make_turn
    return :open if wants_to_open

    case hand.count_points
    when 1..17
      hand.cards.length < Hand.max_cards_amount ? :pull : :open
    else
      :open
    end
  end
end
