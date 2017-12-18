class Disc

  attr_reader :name, :color, :disc
  def initialize(name)
    @name = name
    @color = color_picker
    @disc = "●".colorize(@color)
  end

  def color_picker
    p_1 = $player_array[0]
    if defined?(p_1.color) != nil
      if p_1.color == :yellow
        :red
      else
        :yellow
      end
    else
      print "\nPick a color: yellow or red (y/r)\n> "
      response = STDIN.gets.chomp()
      input = response[0]
      while input != "y" && input != "r"
        print "Sorry, please pick a valid color: yellow or red (y/r)\n> "
        response = STDIN.gets.chomp()
        input = response[0]
      end

      case input
      when "y"
        :yellow
      when "r"
        :red
      end
    end
  end
end
