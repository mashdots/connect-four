# +-+-+-+-+-+-+-+ +-+
# |C|O|N|N|E|C|T| |4|
# +-+-+-+-+-+-+-+ +-+
# Ruby Connect-4 v1.0b
# by Josh Hembree (mashdots)

require_relative 'captainsmistress'
require 'pry'
$player_array = []

welcome
puts "\nWelcome to Ruby Connect 4!"
# sleep(2)

player_setup($player_array)

game = Grid.new
$winner = play($player_array, game)

if $winner == false
  puts "\nIt's a tie game!"
else
  puts "\n#{$winner} wins!".upcase.colorize(:green)
end
