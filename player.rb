require_relative 'hand'

# Represents Player in game
class Player
  attr_accessor :hand, :cash, :name, :wants_to_open

  TURN_OPTIONS = %i[skip pull open].freeze
  NAME_WIDTH = 13

  def initialize(name)
    @hand = Hand.new
    @cash = 100.0
    @wants_to_open = false
    @name = name
  end

  def make_turn
    return :open if wants_to_open

    puts 'Enter your turn: skip/pull/open'
    turn = gets.chomp.to_sym
    raise 'Wrong turn' unless TURN_OPTIONS.include?(turn)

    turn
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def draw(winners = [], cash_won = 0)
    result = "#{name}:".ljust(NAME_WIDTH) + hand.draw + " cash: #{cash}USD"
    result += "(+#{cash_won}USD)" if winners.include?(self)
    result
  end

  def draw_hidden
    "#{name}:".ljust(NAME_WIDTH) + hand.draw_hidden + " cash: #{cash}USD"
  end
end
