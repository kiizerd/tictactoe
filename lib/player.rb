class Player

  attr_reader :shape, :name

  def initialize(number)
    @name = "Player #{number}"
    @score = 0
    @shape = number == 1 ? "X" : "O"
  end

  def make_move
    choice = gets.chomp.to_i
    while choice < 1 || choice > 9
      puts "Error. Try again. \n"
      choice = gets.chomp.to_i
    end
    choice 
  end
end

class Human < Player
end

class Computer < Player
  def make_move
    rand(1..9) 
  end
end
