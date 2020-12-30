# frozen_string_literal: true
# Simple object for generating input
class Player
  attr_reader :name, :shape

  def initialize(num)
    @name = "Player#{num}"
    @shape = num == 1 ? 'X' : 'O'
  end

  def make_move
    (rand 8) + 1
  end
end

# Gets input from user instead of random num
class Human < Player
  def make_move
    move = gets.chomp.to_i
    until (move >= 1) && (move <= 9)
      puts 'Error, input outside range (1 - 9)'
      move = gets.chomp.to_i
    end
    move
  end
end

# Rename of Player class for clarity
class Comp < Player
end
