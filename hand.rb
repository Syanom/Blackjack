require_relative 'card'

# Hands of our players
class Hand
  attr_accessor :cash
  attr_reader :cards

  def initialize
    @cards = []
    @cash = 100
  end

  def count_points
    ace = false
    points = 0
    cards.each do |card|
      if card.rank == 'A'
        ace = true
        next
      end
      points += card.value
    end
    return points if ace == false

    points += points + 11 <= 21 ? 11 : 1
  end

  def drop_cards
    result = []
    result.push(*cards)
    cards.clear
    result
  end

  def take_cards(*cards_to_take)
    cards.push(*cards_to_take)
  end

  def draw
    result = ''
    cards.each do |card|
      result += "#{card.draw} "
    end
    result += "                     cash: #{cash}"
  end
end
