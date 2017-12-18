
class Grid
  attr_accessor :play_grid
  def initialize
    @play_grid = []
    grid_builder
  end

  def grid_builder
    until @play_grid.length == 7
      column = []
      until column.length == 6
        column.push(" ")
      end
      @play_grid.push(column)
    end
  end

  def frame_builder
    system "clear" or system "cls"

    # regular frame constructors
    top_bottom_frame = "   ||=================================||\n".colorize(:blue)
    mid_hor_frame = "   ||===||===||===||===||===||===||===||\n".colorize(:blue)
    row_start_pillar =  "   || ".colorize(:blue)
    frame_pillar = " || ".colorize(:blue)
    row_end_pillar = " ||".colorize(:blue)

    # row builder
    row_array_string = ""
    row_num = 0

    until row_num == @play_grid[0].length
      setup = row_start_pillar
      @play_grid.each_with_index do | column, index |
        if index < @play_grid.length-1
          pillar = frame_pillar
        else
          pillar = row_end_pillar
        end

        if column[row_num] == " "
          slot = column[row_num]
        else
          slot = column[row_num].disc
        end
        setup += slot + pillar
      end

      if row_num == @play_grid[0].length-1
        row_sep = top_bottom_frame
      else
        row_sep = mid_hor_frame
      end

      row_array_string.prepend(row_sep + setup + "\n")
      row_num += 1
    end

    # mid-legs with column index
    legs_with_index = "  //"
    @play_grid.each_with_index do | column, index |
      legs_with_index += "  #{index+1}  "
    end
    legs_with_index += "\\\\\n"

    # bottom legs of grid
    base = " //                                     \\\\\n".colorize(:blue)

    # full construct
    frame = "\n" + row_array_string + top_bottom_frame + legs_with_index.colorize(:blue) + base

    frame
  end

  def drop_disc(column, player)
    @play_grid[column-1].each_with_index do | slot, index |
      if slot == " "
        @play_grid[column-1][index] = player
        return [column-1, index]
      end
    end
  end

  def check_board(player)
    def connect4?(array, h, v)
      validator = nil
      group = array.chunk{|e| e}.map{|_, g| g}

      group.each_with_index do | cluster, i |
        group.delete_at(i) if cluster.include?(" ")
      end

      group.each do | check |
        if check.length >= 4
          validator = check[0].name
        end
      end

      return validator
    end

    def tied
      rows_w_empty_slots = 0
      @play_grid.each do | row |
        if row.include?(" ")
          rows_w_empty_slots += 1
        end
      end
      if rows_w_empty_slots == 0
        return true
      end
    end

    def hor_check(h, v)
      validation = @play_grid.map{|x| x[v]}
      return connect4?(validation, h, v)
    end

    # this checks for connect-4 vertically
    def ver_check(h, v)
      validation = @play_grid[h]
      return connect4?(validation, h, v)
    end

    def diag_a_check(h,v)
      validation = [@play_grid[h][v]]
      i = h
      w = v

      until i == 0 || w == 0 do
        i -= 1
        w -= 1
        validation.unshift(@play_grid[i][w])
      end

      i = h
      w = v

      until i == @play_grid.length - 1 || w == @play_grid[0].length - 1 do
        i += 1
        w += 1
        validation.push(@play_grid[i][w])
      end

      return connect4?(validation, h, v)
    end

    def diag_b_check(h,v)
      validation = [@play_grid[h][v]]
      i = h
      w = v

      until i == 0 || w == @play_grid[0].length - 1 do
        i -= 1
        w += 1
        validation.unshift(@play_grid[i][w])
      end

      i = h
      w = v

      until i == @play_grid.length - 1 || w == 0 do
        i += 1
        w -= 1
        validation.push(@play_grid[i][w])
      end

      return connect4?(validation, h, v)
    end

    disc_h = player[0]
    disc_v = player[1]

    tie = tied

    if tie == true
      return false
    else
      if hor_check(disc_h, disc_v) != nil
        return hor_check(disc_h, disc_v)
      elsif ver_check(disc_h, disc_v) != nil
        return ver_check(disc_h, disc_v)
      elsif diag_a_check(disc_h, disc_v) != nil
        return diag_a_check(disc_h, disc_v)
      else
        return diag_b_check(disc_h, disc_v)
      end
    end


  end
end
