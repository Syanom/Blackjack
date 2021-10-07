require_relative 'hand'

# Hand for diller
class DealerHand < Hand
  def draw
    result = ''
    cards.each do |_card|
      result += '[***] '
    end
    result += "                     #{cash}"
  end
end
