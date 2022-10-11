require 'pry-byebug'

class Board
  attr_accessor :pieces
  def initialize
    @board = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
    @pieces = []
  end

  def display
    @board.each { |x| puts x.to_s.gsub("nil", "-").gsub('"',"") }
  end

  def add_piece(row, column, x_or_o)
    @board[row][column] = x_or_o
    @pieces << Piece.new(row, column, x_or_o, self)
  end

  def get_input(side_to_go)
    valid = false
    while !valid
      puts "Row to add #{side_to_go}:"
      x_row = gets.chomp.to_i
      puts "Col to add #{side_to_go}:"
      x_col = gets.chomp.to_i
      if x_row.is_a?(Integer) && x_col.is_a?(Integer) && x_row.between?(0,2) && x_col.between?(0,2)
        if has_piece(x_row, x_col)
          puts "A piece is already there!"
        else
          valid = true
          add_piece(x_row, x_col, side_to_go)
        end
      else
        puts "Enter a value from 0 to 2"
      end
    end
  end

  def has_piece(row, column)
    @board.dig(row,column) == "x" || @board.dig(row,column) == "o"
  end

  def has_x_or_o(row, column, x_or_o)
    @board.dig(row,column) == x_or_o
  end

  def game_over?
    @pieces.each do |piece| 
      if piece.winning?
        puts "#{piece.x_or_o} wins the game"
        return true
        break
      end
    end
    if @board.flatten.include?(nil) == false
      puts "It's a tie game."
      return true
    end
    return false
  end

end

class Piece
  attr_reader :x_or_o

  def initialize(row, column, x_or_o, board)
    @row = row
    @column = column
    @x_or_o = x_or_o
    @board = board
  end

  def winning?
    # if horizontal three-in-a-row
    if @board.has_x_or_o(@row+1,@column, @x_or_o) && @board.has_x_or_o(@row+2,@column, @x_or_o)
      return true
    #elseif vertical three-in-a-row
    elsif @board.has_x_or_o(@row, @column+1, @x_or_o) && @board.has_x_or_o(@row, @column+2, @x_or_o)
      return true
    #elseif diagonal three-in-a-row slanting to bottom right
    elsif @board.has_x_or_o(@row+1, @column+1, @x_or_o) && @board.has_x_or_o(@row+2, @column+2, @x_or_o)
      return true
    #elseif diagonal three-in-a-row slanting to bottom left
    elsif @board.has_x_or_o(0, 2, @x_or_o) && @board.has_x_or_o(1, 1, @x_or_o) && @board.has_x_or_o(2, 0, @x_or_o)
      return true
    else
      return false
    end

  end

  def display_board
    @board.display
  end

end


