require_relative 'player'
require_relative 'dealer'
require_relative 'deck'

# Runs the game
class GameManager
  def initialize
    @deck = Deck.new
    @players = []
    @players << Player.new << Dealer.new
  end

  def start_game
    loop do
      loop do
        players.each do |player|
          case player.make_turn
          when :skip
            next
          when :pull
            player.take_card(deck)
          when :open
            break
          end
        end
      end
      another_game?
    end
  end

  def another_game?
    print 'Do you want another game? y/n: '
    case gets.chomp
    when 'y'
      return_cards
      next
    when 'n'
      break
    else
      raise 'Wrong command'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end
end
