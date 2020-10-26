#!/usr/local/bin/ruby -w

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

class Game

  @total_games = 0
  @x_wins = 0
  @o_wins = 0

  def initialize
    start_game()
  end
  
  def start_game
    get_players()

    @array = [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "]
    update_display()
    
    @first = @players.sample
    puts "\tNew game started. \n\t#{@first.name} goes first \n" 
    @current = @first
    play_game()
  end
  
  def update_display
    @display = ''
    (1..9).each do |i|
      if i == 1 || i == 4 || i == 7
        @display += "\t"
      end
      @display += i % 3 == 0 ? "#{@array[i]}\n": "#{@array[i]}" + " | "
      if i == 3 || i == 6 
        @display += "\t--+---+--\n"
      end
    end
    print @display
  end

  def get_players
    puts "\tHow many human players? (0, 1, 2) \n"
    @players = gets.chomp.to_i
    
    while @players > 2 || @players < 0
      puts "Error. Try again \n"
      @players = gets.chomp.to_i
    end

    case @players
    when 0
      player1 = Computer.new(1)
      player2 = Computer.new(2)
    when 1
      player1 = Player.new(1) 
      player2 = Computer.new(2)
    when 2
      player1 = Player.new(1)
      player2 = Player.new(2)
    end
    @players = [player1, player2]
  end

  def get_move
    puts "\t#{@current.name}'s turn. \n\tChoose a position. (1-9) \n"
    choice = @current.make_move
    while @array[choice] != " "
      print @display, "\n"
      puts "Space already taken, try again. \n"
      choice = @current.make_move
    end
    @array[choice] = @current.shape
  end
  
  def play_game
    c = 1
    while c <= 9
      get_move()
      update_display()
      if win_game?
        break
      end
      @current = @current == @players[0] ? @players[1] : @players[0]
      c += 1
    end
    game_end("none")
  end

  def win_game?
    if  @array[5] == "X" && @array[1] == "X" && @array[9] == "X" ||
        @array[1] == "X" && @array[2] == "X" && @array[3] == "X" ||
        @array[4] == "X" && @array[5] == "X" && @array[6] == "X" ||
        @array[7] == "X" && @array[8] == "X" && @array[9] == "X" ||
        @array[2] == "X" && @array[5] == "X" && @array[8] == "X" ||
        @array[5] == "X" && @array[3] == "X" && @array[7] == "X" ||
        @array[1] == "X" && @array[4] == "X" && @array[7] == "X" ||
        @array[3] == "X" && @array[6] == "X" && @array[9] == "X"
          game_end("X")
          return true
    elsif @array[5] == "O" && @array[1] == "O" && @array[9] == "O" ||
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
      puts "\tX wins! \n"
      @x_wins += 1
    when "O" 
      puts "\tO wins! \n"
      @o_wins += 1
    else
      puts "\tNo winner. \n"
    end
    @total_games += 1
    puts "\tPlay again? (Y/N) \n"
    @new_game = gets.chomp.upcase
    if @new_game == "Y"
      puts "\tStarting new game! \n"
      start_game()
    elsif @new_game == "N"
      puts "\tGoodbye \n"
      exit
    else
      exit
    end
  end
end

Game.new
