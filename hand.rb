require_relative 'card'

# Hands of our players
class Hand
  attr_reader :cards, :max_cards_amount, :hand_width

  POINTS_WIDTH = 15

  def initialize
    @cards = []
    @max_cards_amount = 3
    @hand_width = Card::CARD_WIDTH * @max_cards_amount + POINTS_WIDTH
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
      result += card.draw
    end
    result = result.ljust(max_cards_amount * Card::CARD_WIDTH) + "points: #{count_points}".rjust(POINTS_WIDTH)
    result.ljust(hand_width)
  end

  def draw_hidden
    result = ''
    cards.each do
      result += '[***]'.ljust(Card::CARD_WIDTH)
    end
    result.ljust(hand_width)
  end

  def count_cards
    cards.length
  end
end
