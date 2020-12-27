require_relative '../lib/game'
require_relative "../lib/player"

describe Game do

  describe "#get_players" do

    subject(:game_players) { described_class.new }

    context "incorrect input" do
      it "outputs error message once" do
        error_message = "Error, try again (0 / 1 / 2)"
        expect(game_players).to receive(:puts).with(error_message).once
        game_players.get_players(3)        
      end
    end

    context "1 human players" do   
      it "returns an array with 1 Human and 1 Comp Player" do
        allow(game_players).to receive(:gets).and_return('1')
        players = game_players.get_players
        expect(players[0]).to be_a(Human)
      end
    end
    
    it "all elements should have Player superclass" do
      players = game_players.get_players
      expect(players).to all ( be_a(Player) )
    end

  end

  describe "#get_move" do

    subject(:game_move) { described_class.new }
    let(:players) { game_move.players }

    context "when called with Human player as argument" do
      it "outputs input message" do
        allow(players.first).to receive(:gets).and_return('5')
        input_message = "Input move position (1 - 9)"
        expect(game_move).to receive(:puts).with(input_message).once
        allow(game_move).to receive(:puts).with(String)
        game_move.get_move(players.first)
      end
    end

    context "move is successful" do
      it "outputs position taken message" do
        allow(players.first).to receive(:gets).and_return('7')
        success_message = "#{players.first.name} taken position 7"
        allow(game_move).to receive(:puts).with(String)
        expect(game_move).to receive(:puts).with(success_message).once
        game_move.get_move(players.first)
      end
    end

    context "position is taken" do
      it "outputs error message once" do
        game_move.array[6] = 'X'
        allow(players.first).to receive(:gets).and_return('7', '5')
        error_message = "Error, position taken, try again."
        allow(game_move).to receive(:puts).with(String)
        expect(game_move).to receive(:puts).with(error_message).once
        game_move.get_move(players.first)
      end
    end

  end

  describe "#check_move" do

    subject(:game_check) { described_class.new }
    let(:players) { game_check.players }

    context "when given move with taken position" do
      it "should return false" do
        allow(players.first).to receive(:make_move).and_return(5)
        game_check.array[4] = players.first.shape
        check = game_check.check_move(players.first.make_move)
        expect(check).to be(false)
      end
    end
    
    context "when given good input" do
      it "should return true" do
        allow(players.first).to receive(:make_move).and_return(5)
        check = game_check.check_move(players.first.make_move)
        expect(check).to be(true)
      end
    end
  end

  describe "#update_display" do

    subject(:game_display) { described_class.new }
    let(:players) { game_display.get_players(2) }

    context "on game start" do
      it "should output empty grid" do
        expect(game_display).to receive(:print).with($empty_display)
        game_display.update_display
      end
    end

    context "on X's turn" do
      it "displays X in correct position" do
        allow(players.first).to receive(:make_move).and_return(8)
        game_display.get_move(players.first)
        game_display.update_display
        expect(game_display.display).to include(players.first.shape)
      end
    end

    context "on O's turn" do
      it "displays O in correct position" do
        allow(players.last).to receive(:make_move).and_return(4)
        game_display.get_move(players.last)
        game_display.update_display
        expect(game_display.display).to include(players.last.shape)
      end
    end
  end

  describe "#win_game?" do

    subject(:game_complete) { described_class.new }

    context "win conditions not met" do
      it "should return false" do
        check = game_complete.win_game?
        expect(check).to be(false)
      end
    end

    context "win conditions met" do
      it "should return true" do
        game_complete.array[0] = "X"
        game_complete.array[4] = "X"
        game_complete.array[8] = "X"
        check = game_complete.win_game?
        expect(check).to be(true)
      end
    end
  end

  describe "#game_over" do

    subject(:game_winner) { described_class.new }
    let(:players) { subject.players }

    context "game has been won" do
      
      it "should display 'O' as winner" do
        winner = 'O'
        win_message = "#{winner} has won. Congratulations!!"
        expect(game_winner).to receive(:puts).with(win_message)
        game_winner.game_over(winner)
      end

      it "shoukd display 'X' as winner" do
        winner = "X"
        
        winner = 'O'
        win_message = "#{winner} has won. Congratulations!!"
        expect(game_winner).to receive(:puts).with(win_message)
        game_winner.game_over(winner)
      end
    end
  end
end

$empty_display = <<-EMPTY
\t  |   |  
\t--+---+--
\t  |   |  
\t--+---+--
\t  |   |  

               EMPTY