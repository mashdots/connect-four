require_relative 'disc'
require_relative 'grid'
require 'pry'
require 'colorize'

# Bug Log:
# - If colors are separated, and spaces are then removed, if they total to connect 4, they count as a win.
# - array validation for diagonal connects


# display game title
def welcome
  system "clear" or system "cls"
  puts "\n____________________________________________________________________________\n"
  puts "      __       __      _    _    _    _    _____     __   ______            \n"
  puts "    /    )   /    )   /|   /    /|   /    /    '   /    )   /        /    / \n"
  puts "---/--------/----/---/-| -/----/-| -/----/__------/--------/--------/____/--\n"
  puts "  /        /    /   /  | /    /  | /    /        /        /             /   \n"
  puts "_(____/___(____/___/___|/____/___|/____/____ ___(____/___/_____________/____\n"
end

# creates player array, assigning name and disc color
def player_setup(array)
  i = 0
  until array.length == 2
    print "\nPlayer #{i+1}, what is your name?\n> "
    player_name = gets.chomp
    array.push(Disc.new(player_name))
    puts "You are #{array[i].color}!".colorize(array[i].color.to_sym)
    i += 1
    # sleep(1)
  end
end


def play(players, game_grid)
  winner = nil
  column_range = (1..7)
  while winner == nil
    players.each do | player |
      puts game_grid.frame_builder
      player_prompt(player, 1)
      player_move = gets.to_i

      while !column_range.include?(player_move) || !game_grid.play_grid[player_move-1].include?(" ")
        if !column_range.include?(player_move)
          player_prompt(player, 2)
        else
          player_prompt(player, 3)
        end
        player_move = gets.to_i
      end

      disc_location = game_grid.drop_disc(player_move, player)

      winner = game_grid.check_board(disc_location)

      if winner != nil
        puts game_grid.frame_builder
        case winner
        when "tie"
          return "tie"
        else
          return winner
        end
      end
    end
  end
end


def player_prompt(player, opt)
  case opt
  when 1
    print "#{player.name.colorize(player.color)}, type in a column number and press enter.\n> "
  when 2
    print "Please pick a valid column number and press enter.\n> "
  when 3
    print "Sorry, that column is full. Please pick another.\n> "
  end
end
