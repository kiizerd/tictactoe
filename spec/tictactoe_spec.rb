require './lib/tictactoe'

describe Game do
  describe "#win_game?" do
    it "returns false if no one has won" do
      game = Game.new
      expect(game.win_game?).to eql(false)
    end

    it "returns true if someone has won" do
      game = Game.new
      game.array[3] = "X"
      game.array[1] = "X"
      game.array[2] = "X"
      expect(game.win_game?).to eql(true)
    end
  end
end
