require_relative 'game_manager'

begin
  GameManager.new.start_game
rescue RuntimeError => e
  puts e.message
end
