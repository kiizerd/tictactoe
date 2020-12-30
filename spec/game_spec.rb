# frozen_string_literal: true

require './lib/game'
require './lib/player'

describe Game do
  describe '#get_players' do
    subject(:game_players) { described_class.new }

    context 'with incorrect input' do
      it 'outputs error message once' do
        error = "Error, try again (0 / 1 / 2)\n"
        expect { game_players.get_players(3) }.to output(error).to_stdout
      end
    end

    context 'when 1 human player' do
      it 'returns an array with 1 Human and 1 Comp Player' do
        players = game_players.get_players 1
        expect(players[0]).to be_a(Human)
      end
    end

    it 'all elements should have Player superclass' do
      players = game_players.get_players
      expect(players).to all(be_a(Player))
    end
  end

  describe '#get_move' do
    subject(:game_move) { described_class.new }

    let(:players) { game_move.players }

    context 'when move is successful' do
      it 'outputs success message' do
        allow(players.first).to receive(:gets).and_return('7')
        input = 'Input move position (1 - 9)'
        success = "#{players.first.name} taken position 7"
        expect { game_move.get_move(players.first) }.to output(input && success && game_move.display).to_stdout
      end
    end

    context 'when position is taken' do
      before do
        allow(players.first).to receive(:gets).and_return('7', '5')
        game_move.array[6] = 'X'
      end

      it 'outputs error and display' do
        error = 'Error, position taken, try again.\n'
        expect { game_move.get_move(players.first) }.to output(error && game_move.display).to_stdout
      end
    end
  end

  describe '#check_move' do
    subject(:game_check) { described_class.new }

    let(:players) { game_check.players }

    context 'when given move with taken position' do
      it 'returns false' do
        allow(players.first).to receive(:make_move).and_return(5)
        game_check.array[4] = players.first.shape
        check = game_check.check_move(players.first.make_move)
        expect(check).to be(false)
      end
    end

    context 'when given good input' do
      it 'returns true' do
        allow(players.first).to receive(:make_move).and_return(5)
        check = game_check.check_move(players.first.make_move)
        expect(check).to be(true)
      end
    end
  end

  describe '#update_display' do
    subject(:game_display) { described_class.new }

    let(:players) { game_display.get_players(2) }

    context 'when game starts' do
      it 'outputs empty grid' do
        empty = "\t  |   |  \n\t--+---+--\n\t  |   |  \n\t--+---+--\n\t  |   |  \n\n"
        expect { game_display.update_display }.to output(empty).to_stdout
      end
    end

    context "when X's turn" do
      it 'displays X in correct position' do
        allow(players.first).to receive(:make_move).and_return(8)
        game_display.get_move(players.first)
        game_display.update_display
        expect(game_display.display).to include(players.first.shape)
      end
    end

    context "when O's turn" do
      it 'displays O in correct position' do
        allow(players.last).to receive(:make_move).and_return(4)
        game_display.get_move(players.last)
        game_display.update_display
        expect(game_display.display).to include(players.last.shape)
      end
    end
  end

  describe '#win_game?' do
    subject(:game_complete) { described_class.new }

    context 'without win conditions met' do
      it 'returns false' do
        check = game_complete.win_game?
        expect(check).to be(false)
      end
    end

    context 'with win conditions met' do
      it 'returns true' do
        game_complete.array[0] = 'X'
        game_complete.array[4] = 'X'
        game_complete.array[8] = 'X'
        check = game_complete.win_game?
        expect(check).to be(true)
      end
    end
  end

  describe '#game_over' do
    subject(:game_winner) { described_class.new }

    let(:players) { subject.players }

    context 'when game has been won' do
      it "displays 'O' as winner" do
        winner = 'O'
        win_message = "#{winner} has won. Congratulations!!\n"
        expect { game_winner.game_over(winner) }.to output(win_message).to_stdout
      end

      it "displays 'X' as winner" do
        winner = 'X'
        win_message = "#{winner} has won. Congratulations!!\n"
        expect { game_winner.game_over(winner) }.to output(win_message).to_stdout
      end
    end
  end
end
