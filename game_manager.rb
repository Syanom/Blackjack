require_relative 'player'
require_relative 'dealer'
require_relative 'deck'

# Runs the game
class GameManager
  def initialize
    @deck = Deck.new
    @deck.shuffle
    @players = []
    # Add as many human players (Player.new) or computer players (Dealer.new) as you want
    @players << Player.new << Dealer.new
    @bank = 0.0
  end

  def start_game
    loop do
      make_bets
      loop do
        break if make_turns == :open
      end
      make_results
      cards = another_game?
      cards.nil? ? break : deck.return_cards(*cards)

      # Comment next line if you don't want to shuffle deck after every game
      deck.shuffle
    end
  end

  protected

  attr_accessor :players, :bank, :deck, :win_message

  def another_game?
    print 'Do you want another game? y/n: '
    case gets.chomp
    when 'y'
      return_cards
    when 'n'
      nil
    else
      raise 'Wrong command'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def return_cards
    cards = []
    players.each do |player|
      cards.push(*player.hand.drop_cards)
    end
    cards
  end

  def draw_table(current_player)
    puts "Bank: #{bank}USD"
    players.each do |player|
      case current_player
      when player, nil
        puts player.draw
      else
        puts player.draw_hidden
      end
    end
  end

  def players_has_3_cards?
    answer = true
    players.each do |player|
      answer = false if player.hand.count_cards != 3
    end
    answer
  end

  def make_results
    winners = find_winners
    self.bank /= winners.length
    self.win_message = ''
    winners.each do |winner|
      case winner.class.name
      when 'Player'
        win_message << "Player #{winner.id} "
      when 'Dealer'
        win_message << "Player #{winner.id}(computer) "
      end
      winner.cash += self.bank
    end
    system('clear')
    puts "#{win_message} have won!"
    self.bank = 0
    draw_table(nil)
  end

  def find_winners
    competitors = []
    competitors.push(*players)
    competitors.select! { |competitor| competitor.hand.count_points <= 21 }
    winning_value = competitors.map { |competitor| competitor.hand.count_points }.max
    players.select { |player| player.hand.count_points == winning_value }
  end

  def make_bets
    players.each do |player|
      raise "One of the players haven't enough cash. Game finished" if player.cash < 10

      player.cash -= 10
      @bank += 10.0
      player.hand.take_cards(*deck.give_cards(2))
    end
  end

  def make_turns
    cmd = :empty
    players.each do |player|
      system('clear')
      if player.instance_of?(Player)
        puts "Player#{player.id}'s turn"
        gets
      end
      draw_table(player)
      cmd = player.make_turn
      case cmd
      when :pull
        player.hand.take_cards(*deck.give_cards(1))
      when :open
        puts "line 129 cmd = #{cmd}"
        break
      end
    end
    puts "line 133 cmd = #{cmd}"
    return :open if cmd == :open || players_has_3_cards?
  end
end
