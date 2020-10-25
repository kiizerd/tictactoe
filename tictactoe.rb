#!/usr/local/bin/ruby -w

class Game
  def initialize
    @guide = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @array = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    start_game()
  end

  def start_game
    @guide = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @array = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    update_display()
    @first = ["X", "O"].sample
    puts "New game started. #{@first} goes first"
    @current = @first
    play_game()
  end
  
  def update_display
    @display = ''
    (1..9).each do |i|
      @display += i % 3 == 0 ? "#{@array[i]}" + "\n": "#{@array[i]}" + ' | '
      if i == 3 || i == 6 
        @display += "--+---+--\n"
      end
    end
    print @display
  end

  def play_game
    c = 1
    while c <= 9
      puts "#{@current}'s turn. Choose a position. (1-9)"
      choice = gets.chomp.to_i
      while choice < 1 || choice > 9
        puts "Error. Try again."
        choice = gets.chomp.to_i
      end
      while @array[choice] != " "
        puts "Space already taken, try again."
        choice = gets.chomp.to_i
      end
      @array[choice] = @current
      update_display()
      if win_game?
        break
      end
        @current = @current == "X" ? "O": "X"
      c += 1
    end
  end

  def win_game?
    if
      @array[5] == "X" && @array[1] == "X" && @array[9] == "X" ||
      @array[1] == "X" && @array[2] == "X" && @array[3] == "X" ||
      @array[4] == "X" && @array[5] == "X" && @array[6] == "X" ||
      @array[7] == "X" && @array[8] == "X" && @array[9] == "X" ||
      @array[2] == "X" && @array[5] == "X" && @array[8] == "X" ||
      @array[5] == "X" && @array[3] == "X" && @array[7] == "X" ||
      @array[1] == "X" && @array[4] == "X" && @array[7] == "X" ||
      @array[3] == "X" && @array[6] == "X" && @array[9] == "X"
        game_end("X")
        return true
    elsif
      @array[5] == "O" && @array[1] == "O" && @array[9] == "O" ||
      @array[1] == "O" && @array[2] == "O" && @array[3] == "O" ||
      @array[4] == "O" && @array[5] == "O" && @array[6] == "O" ||
      @array[7] == "O" && @array[8] == "O" && @array[9] == "O" ||
      @array[2] == "O" && @array[5] == "O" && @array[8] == "O" ||
      @array[5] == "O" && @array[3] == "O" && @array[7] == "O" ||
      @array[1] == "O" && @array[4] == "O" && @array[7] == "O" ||
      @array[3] == "O" && @array[6] == "O" && @array[9] == "O"
        game_end("O")
        return true
    end
    return false
  end

  def game_end(winner)
    @winner = winner
    case winner
    when "X"
      puts "X wins!"
    when "O" 
      puts "O wins!"
    else
      puts "No winner."
    end
    puts "@first: #{@first}"
    puts "@current: #{@current}"
    puts "@winner #{@winner}"
    puts "Play again? (Y/N)"
    @new_game = gets.chomp.upcase
    if @new_game == "Y"
      puts "Starting new game!"
      start_game()
    elsif @new_game == "N"
      puts "Goodbye"
      exit
    else
      exit
    end
  end
end

Game.new
