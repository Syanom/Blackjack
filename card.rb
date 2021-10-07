# Cards for the game
class Card
  attr_reader :value, :rank, :suit

  def initialize(rank, suit)
    @suit = suit
    @rank = rank
    validate!
    @value = VALUES_BY_RANKS[rank]
  end

  def draw
    card = "[#{rank}"
    card + case suit
           when '+', '^'
             " #{suit}]"
           else
             "#{suit}]"
           end
  end

  protected

  VALUES_BY_RANKS = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
                      'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }.freeze

  SUITS = ['+', '<3', '^', '<>'].freeze

  def validate!
    errors = []
    errors << "Card's rank: #{rank} is invalid" if VALUES_BY_RANKS[rank].nil?
    errors << "Card's suit is invalid: #{suit}" unless SUITS.include?(suit)
    raise errors.join('. ') unless errors.empty?
  end
end
