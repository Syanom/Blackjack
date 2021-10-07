require_relative 'card'

# Deck for the game
class Deck
  def initialize
    @cards = []
    Card.ranks.each do |rank|
      Card.suits.each { |suit| @cards << Card.new(rank, suit) }
    end
  end

  def shuffle
    cards.shuffle!
  end

  def return_cards(*cards_to_return)
    validate_cards!(*cards_to_return)
    cards.push(*cards_to_return)
  end

  def give_cards(amount)
    result = []
    amount.times do
      result << cards.shift
    end
    result
  end

  protected

  def validate_cards!(*cards_to_validate)
    errors = []
    cards_to_validate.each do |card|
      errors << 'Given card is invalid' unless card.is_a?(Card)
      errors << 'Card is in deck already' if include_card?(card)
    end
    raise errors.join('. ') unless errors.empty?
  end

  def include_card?(card)
    cards.each do |card_in_deck|
      return true if card_in_deck.rank == card.rank && card_in_deck.suit == card.suit
    end
    false
  end

  attr_accessor :cards
end
