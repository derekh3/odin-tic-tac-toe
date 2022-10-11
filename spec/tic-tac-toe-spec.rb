require './lib/tic-tac-toe.rb'

describe Board do
  describe "#display" do
    context "when displaying pieces" do
      subject(:game_board1) { Board.new() }
      before do
        allow(game_board1).to receive(:puts).exactly(3).times
      end
      it "sends a puts message 9 times" do
        expect(game_board1).to receive(:puts).exactly(3).times
        game_board1.display
      end
    end
  end

  describe "#add_piece" do
    context "when adding an x to an empty board" do
      subject(:game2) { Board.new() }
      before do
        game2.add_piece(2,2, "x")
      end

      it "shows the x in the @board variable" do
        board = game2.instance_variable_get(:@board)
        expect(board).to eq([[nil,nil,nil],[nil,nil,nil],[nil,nil,"x"]])
      end

      it "shows a piece with side x in the @pieces variable" do
        pieces = game2.instance_variable_get(:@pieces)
        expect(pieces[0].instance_variable_get(:@x_or_o)).to eq("x")
      end
    end

    context "when adding an x to an empty board" do
      subject(:game3) { Board.new() }
      before do
        game3.add_piece(2,2, "o")
      end
      
      it "shows the x in the @board variable" do
        board = game3.instance_variable_get(:@board)
        expect(board).to eq([[nil,nil,nil],[nil,nil,nil],[nil,nil,"o"]])
      end

      it "shows a piece with side x in the @pieces variable" do
        pieces = game3.instance_variable_get(:@pieces)
        expect(pieces[0].instance_variable_get(:@x_or_o)).to eq("o")
      end
    end
  end

  describe "#get_input" do
    subject(:game) { Board.new() }
    context "when user inputs 1 and then 2" do
      before do
        allow(game).to receive(:gets).and_return("1","2")
        allow(game).to receive(:puts).twice
      end
      it "captures the input" do
        expect(game).to receive(:gets).twice
        game.get_input("x")
      end

      it "adds a piece at (1,2)" do
        expect(game).to receive(:add_piece).with(1,2,"x")
        game.get_input("x")
      end

    end
    context "when user inputs 4 and then 5 then 1 and 2" do
      before do
        allow(game).to receive(:gets).and_return("4","5", "1","2")
        
      end

      it "adds a piece at (1,2)" do
        expect(game).to receive(:add_piece).with(1,2,"x")
        game.get_input("x")
      end
    end

  end

  describe "#has_piece" do
    subject(:game) { Board.new() }
    context "an empty board" do
      it "does not have piece at location (1, 1)" do
        expect(game.has_piece(1,1)).to eq(false)
      end
    end
    context "a board with an x at (1,1)" do
      before do
        game.add_piece(1,1,"x")
      end
      it "does have a piece at location (1, 1)" do
        expect(game.has_piece(1,1)).to eq(true)
      end
    end
  end

  describe "#game_over" do
    subject(:game) { Board.new() }
    context "an empty board" do
      it "is not game over" do
        expect(game.game_over?).to eq(false)
      end
    end
    context "3 x's in a row" do
      before do
        game.add_piece(0,0,"x")
        game.add_piece(0,1,"x")
        game.add_piece(0,2,"x")
        # allow(game).to receive(:puts).once
      end
      it "is game over" do
        expect(game.game_over?).to eq(true)
      end
      it "outputs x wins the game" do
        expect { game.game_over? }.to output("x wins the game\n").to_stdout
      end
    end

    context "3 o's in a row" do
      before do
        game.add_piece(0,0,"o")
        game.add_piece(0,1,"o")
        game.add_piece(0,2,"o")
        # allow(game).to receive(:puts).once
      end
      it "is game over" do
        expect(game.game_over?).to eq(true)
      end
      it "outputs o wins the game" do
        expect { game.game_over? }.to output("o wins the game\n").to_stdout
      end
    end

    context "3 x's in a col" do
      before do
        game.add_piece(0,0,"x")
        game.add_piece(1,0,"x")
        game.add_piece(2,0,"x")
        # allow(game).to receive(:puts).once
      end
      it "is game over" do
        expect(game.game_over?).to eq(true)
      end
      it "outputs x wins the game" do
        expect { game.game_over? }.to output("x wins the game\n").to_stdout
      end
    end

    context "3 o's in a col" do
      before do
        game.add_piece(0,0,"o")
        game.add_piece(1,0,"o")
        game.add_piece(2,0,"o")
        # allow(game).to receive(:puts).once
      end
      it "is game over" do
        expect(game.game_over?).to eq(true)
      end
      it "outputs o wins the game" do
        expect { game.game_over? }.to output("o wins the game\n").to_stdout
      end
    end

    context "3 x's in a downward diagonal" do
      before do
        game.add_piece(0,0,"x")
        game.add_piece(1,1,"x")
        game.add_piece(2,2,"x")
        # allow(game).to receive(:puts).once
      end
      it "is game over" do
        expect(game.game_over?).to eq(true)
      end
      it "outputs x wins the game" do
        expect { game.game_over? }.to output("x wins the game\n").to_stdout
      end
    end

    context "3 o's in a downward diagonal" do
      before do
        game.add_piece(0,0,"o")
        game.add_piece(1,1,"o")
        game.add_piece(2,2,"o")
        # allow(game).to receive(:puts).once
      end
      it "is game over" do
        expect(game.game_over?).to eq(true)
      end
      it "outputs o wins the game" do
        expect { game.game_over? }.to output("o wins the game\n").to_stdout
      end
    end

    context "3 x's in an upward diagonal" do
      before do
        game.add_piece(2,0,"x")
        game.add_piece(1,1,"x")
        game.add_piece(0,2,"x")
        # allow(game).to receive(:puts).once
      end
      it "is game over" do
        expect(game.game_over?).to eq(true)
      end
      it "outputs x wins the game" do
        expect { game.game_over? }.to output("x wins the game\n").to_stdout
      end
    end

    context "3 o's in an upward diagonal" do
      before do
        game.add_piece(2,0,"o")
        game.add_piece(1,1,"o")
        game.add_piece(0,2,"o")
        # allow(game).to receive(:puts).once
      end
      it "is game over" do
        expect(game.game_over?).to eq(true)
      end
      it "outputs o wins the game" do
        expect { game.game_over? }.to output("o wins the game\n").to_stdout
      end
    end

    context "full board but no winner" do
      before do
        game.add_piece(0,0,"o")
        game.add_piece(0,1,"o")
        game.add_piece(0,2,"x")

        game.add_piece(1,0,"x")
        game.add_piece(1,1,"x")
        game.add_piece(1,2,"o")

        game.add_piece(2,0,"o")
        game.add_piece(2,1,"x")
        game.add_piece(2,2,"o")
      end
      it "is game over" do
        expect(game.game_over?).to eq(true)
      end
      it "outputs tie game" do
        expect { game.game_over? }.to output("It's a tie game.\n").to_stdout
      end
    end
  end
  

end

describe Piece do

end