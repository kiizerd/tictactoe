# frozen_string_literal: true

require './lib/game'
require './lib/player'

describe Player do
  describe '#make_move' do
    subject(:player_move) { described_class.new(1) }

    it 'returns numbers <= 9 and >= 1' do
      moves_ary = []
      9.times { moves_ary << player_move.make_move }
      expect(moves_ary).to all((be <= 9).and(be >= 1))
    end
  end
end
