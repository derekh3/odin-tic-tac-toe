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

  def has_piece(row, column, x_or_o)
    @board.dig(row,column) == x_or_o
  end
end

class Piece
  def initialize(row, column, x_or_o, board)
    @row = row
    @column = column
    @x_or_o = x_or_o
    @board = board
  end

  def winning?
    # if horizontal three-in-a-row
    if @board.has_piece(@row+1,@column, @x_or_o) && @board.has_piece(@row+2,@column, @x_or_o)
      return true
    #elseif vertical three-in-a-row
    elsif @board.has_piece(@row, @column+1, @x_or_o) && @board.has_piece(@row, @column+2, @x_or_o)
      return true
    #elseif diagonal three-in-a-row slanting to bottom right
    elsif @board.has_piece(@row+1, @column+1, @x_or_o) && @board.has_piece(@row+2, @column+2, @x_or_o)
      return true
    #elseif diagonal three-in-a-row slanting to bottom left
    elsif @board.has_piece(0, 2, @x_or_o) && @board.has_piece(1, 1, @x_or_o) && @board.has_piece(2, 0, @x_or_o)
      return true
    else
      return false
    end

  end

  def display_board
    @board.display
  end

end

board = Board.new
winning = false

side_to_go = "x"
while !winning
  puts "Row to add #{side_to_go}:"
  x_row = gets.chomp.to_i
  puts "Col to add #{side_to_go}:"
  x_col = gets.chomp.to_i
  board.add_piece(x_row, x_col, side_to_go)
  board.display
  board.pieces.each do |piece| 
    if piece.winning?
      winning = true
      puts "#{side_to_go} wins the game"
      break
    end
  end

  side_to_go = side_to_go == "x" ? "o" : "x"
end
