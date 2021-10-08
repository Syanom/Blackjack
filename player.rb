require_relative 'hand'

# Represents Player in game
class Player
  attr_accessor :hand, :id, :cash

  @@instances = 0

  def initialize
    @hand = Hand.new
    @@instances += 1
    @id = @@instances
    @cash = 100.0
  end

  def make_turn
    puts 'Enter your turn: skip/pull/open'
    turn = gets.chomp.to_sym
    raise 'Wrong turn' unless %i[skip pull open].include?(turn)
    raise 'You have 3 cards already. You cant pull anymore' if turn == :pull && hand.cards.length >= 3

    turn
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def draw
    hand.draw + "     cash: #{cash}USD"
  end

  def draw_hidden
    hand.draw_hidden + "     cash: #{cash}USD"
  end
end
