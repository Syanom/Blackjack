require_relative 'hand'

# Hand for diller
class DealerHand < Hand
  def draw
    result = ''
    cards.each do
      result += '[***] '
    end
    result += "                     cash: #{cash}"
  end
end
