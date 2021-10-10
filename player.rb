require_relative 'hand'

# Represents Player in game
class Player
  attr_accessor :hand, :cash, :name, :wants_to_open, :did_skip, :turn_options

  NAME_WIDTH = 13

  def initialize(name)
    @hand = Hand.new
    @cash = 100.0
    @wants_to_open = false
    @did_skip = false
    @name = name
    @turn_options = %i[skip pull open]
  end

  def make_turn
    return :open if wants_to_open

    current_turn_options = did_skip ? turn_options - [:skip] : turn_options
    puts "Enter your turn: #{current_turn_options.join('/')}"
    turn = gets.chomp.to_sym
    raise 'Wrong turn' unless current_turn_options.include?(turn)

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
