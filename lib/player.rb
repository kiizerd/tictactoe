class Player

  attr_reader :name, :shape

  def initialize(num)
    @name = "Player#{num}"
    @shape = num == 1 ? "X" : "O"
  end

  def make_move
    rand 9
  end
end

class Human < Player
  def make_move
    move = gets.chomp.to_i
    until move >= 1 and move <= 9
      puts "Error, input outside range (1 - 9)"
      move = gets.chomp.to_i
    end
    move
  end
end

class Comp < Player

end