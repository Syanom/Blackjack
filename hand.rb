require_relative 'card'

# Hands of our players
class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def count_points
    ace = 0
    points = 0
    cards.each do |card|
      if card.rank == 'A'
        ace += 1
        next
      end
      points += card.value
    end
    return points if ace.zero?

    case ace
    when 1
      points += points + 11 <= 21 ? 11 : 1
    when 2
      points += points + 12 > 21 ? 2 : 12
    when 3
      points = 13
    end
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
      result += card.draw.to_s.ljust(6)
    end
    result.ljust(20) + "points: #{count_points}"
  end

  def draw_hidden
    result = ''
    cards.each do
      result += '[***]'.ljust(6)
    end
    result.ljust(30)
  end

  def count_cards
    cards.length
  end
end
