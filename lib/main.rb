require './lib/tic-tac-toe.rb'

board = Board.new
over = false

side_to_go = "x"
while !over
  
  board.get_input(side_to_go)
  # puts "Row to add #{side_to_go}:"
  # x_row = gets.chomp.to_i
  # puts "Col to add #{side_to_go}:"
  # x_col = gets.chomp.to_i
  # board.add_piece(x_row, x_col, side_to_go)
  board.display
  if board.game_over?
    over = true
    break
  end

  # board.pieces.each do |piece| 
  #   if piece.winning?
  #     winning = true
  #     puts "#{side_to_go} wins the game"
  #     break
  #   end
  # end

  side_to_go = side_to_go == "x" ? "o" : "x"
end