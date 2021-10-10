# Cards for the game
class Card
  attr_reader :value, :rank, :suit

  CARD_WIDTH = 6

  def initialize(rank, suit)
    @suit = suit
    @rank = rank
    validate!
    @value = VALUES_BY_RANKS[rank]
  end

  def draw
    cards_look = "[#{rank}" + case suit
                              when '+', '^'
                                " #{suit}]"
                              else
                                "#{suit}]"
                              end
    cards_look.ljust(CARD_WIDTH)
  end

  def self.ranks
    ranks = []
    VALUES_BY_RANKS.each { |rank, _value| ranks << rank }
    ranks
  end

  def self.suits
    SUITS
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
