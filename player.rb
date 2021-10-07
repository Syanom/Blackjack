require_relative 'hand'

# Represents Player in game
class Player
  attr_accessor :hand

  def initialize
    @hand = Hand.new
  end

  def make_turn
    puts 'Enter your turn: skip/pull/open'
    turn = gets.chomp.to_sym
    raise 'Wrong turn' unless %i[skip pull open].include?(turn)
    raise 'You have 3 cards already. You cant pull anymore' if turn == :pull && hand.cards.length >= 3
  rescue RuntimeError => e
    puts e.message
    retry
  end
end
