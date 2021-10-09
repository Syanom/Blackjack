require_relative 'player'
require_relative 'dealer'
require_relative 'deck'

# Runs the game
class GameManager
  def initialize(players, number_of_ai)
    @deck = Deck.new
    @deck.shuffle
    @players = []
    # Add as many human players (Player.new) or computer players (Dealer.new) as you want
    players.each do |player|
      @players << Player.new(player.capitalize)
    end
    number_of_ai.times do
      @players << Dealer.new
    end
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
      player.wants_to_open = false
      cards.push(*player.hand.drop_cards)
    end
    cards
  end

  def draw_table(current_player, winners = [], win_cash = 0)
    puts "Bank: #{bank}USD"
    players.each do |player|
      case current_player
      when player, nil
        puts player.draw(winners, win_cash)
      else
        puts player.draw_hidden
      end
    end
  end

  def make_results
    winners = find_winners
    self.bank /= winners.length
    self.win_message = ''
    winners.each do |winner|
      win_message << "#{winner.name} "
      winner.cash += self.bank
    end
    system('clear')
    puts "#{win_message} have won!"
    draw_table(nil, winners, self.bank)
    self.bank = 0
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
    players.each do |player|
      system('clear')
      break if open?(players)
      next if player.wants_to_open

      if player.instance_of?(Player)
        puts "#{player.name}'s turn"
        gets
        draw_table(player)
      end
      case player.make_turn
      when :pull
        card = deck.give_cards(1)[0]
        player.hand.take_cards(card)
        if player.instance_of?(Player)
          puts "You've pulled #{card.draw}"
          gets
        end
        player.wants_to_open = true
      when :skip
        next
      when :open
        player.wants_to_open = true
        next
      end
    end
    return :open if open?(players)
  end

  def open?(players)
    return true if players.find { |player| player.wants_to_open == false }.nil?

    false
  end
end
