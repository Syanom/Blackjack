require_relative 'game_manager'

def change_settings?
  puts 'Default settings: 1 human player agains 1 ai player.'
  puts 'Do you want to change settings? y/n'
  case gets.chomp
  when 'y'
    true
  when 'n'
    false
  else
    raise 'Wrong input'
  end
rescue RuntimeError => e
  puts e.message
  retry
end

def get_player_name
  puts "Enter player's name"
  gets.chomp
end

def get_number_of_players(type)
  puts "Enter number of #{type} players"
  gets.chomp.to_i
end

number_of_players = 1
players = []
number_of_ai = 1
if change_settings?
  number_of_players = get_number_of_players('human')
  number_of_ai = get_number_of_players('ai')
end

number_of_players.times do
  players << get_player_name
end

begin
  GameManager.new(players, number_of_ai).start_game
rescue RuntimeError => e
  puts e.message
end
