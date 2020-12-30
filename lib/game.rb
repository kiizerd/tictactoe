# frozen_string_literal: true

require_relative 'player'

# main class
class Game
  attr_reader :players, :array, :display

  def initialize
    @players = get_players 1
    @array = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def play_game
    update_display
    9.times do |_turn|
      @players.each do |p|
        get_move p
      end

      break if win_game?
    end
    game_over(@winner)
  end

  def get_players(response = nil)
    unless response
      puts 'Input number of Human players (0 / 1 / 2)'
      response = gets.chomp.to_i
    end
    until (response >= 0) && (response <= 2)
      puts 'Error, try again (0 / 1 / 2)'
      response = gets.chomp.to_i
    end
    @players = if response.zero?
                 [Comp.new(1), Comp.new(2)]
               elsif response == 1
                 [Human.new(1), Comp.new(2)]
               else
                 [Human.new(1), Human.new(2)]
               end
    @players
  end

  def get_move(player)
    puts 'Input move position (1 - 9)' if player.is_a? Human
    move = player.make_move
    until check_move(move)
      puts 'Error, position taken, try again.' if player.is_a? Human
      move = player.make_move
    end
    puts "#{player.name} taken position #{move}"
    @array[move - 1] = player.shape
    update_display
  end

  def check_move(move)
    @array[move - 1] == ' '
  end

  def update_display
    @display = ''
    (1..9).each do |x|
      @display += "\t" if [1, 4, 7].include?(x)
      @display += (x % 3).zero? ? "#{@array[x - 1]}\n" : "#{@array[x - 1]} | "
      @display += "\t--+---+--\n" if (x == 3) || (x == 6)
    end
    @display += "\n"
    print @display
    @display
  end

  def win_game?
    if  @array[4] == 'X' && @array[0] == 'X' && @array[8] == 'X' ||
        @array[0] == 'X' && @array[1] == 'X' && @array[2] == 'X' ||
        @array[3] == 'X' && @array[4] == 'X' && @array[5] == 'X' ||
        @array[6] == 'X' && @array[7] == 'X' && @array[8] == 'X' ||
        @array[1] == 'X' && @array[4] == 'X' && @array[7] == 'X' ||
        @array[4] == 'X' && @array[3] == 'X' && @array[6] == 'X' ||
        @array[0] == 'X' && @array[3] == 'X' && @array[6] == 'X' ||
        @array[2] == 'X' && @array[5] == 'X' && @array[8] == 'X'
      @winner = 'X'
      return true
    elsif @array[4] == 'O' && @array[0] == 'O' && @array[8] == 'O' ||
          @array[0] == 'O' && @array[1] == 'O' && @array[2] == 'O' ||
          @array[3] == 'O' && @array[4] == 'O' && @array[5] == 'O' ||
          @array[6] == 'O' && @array[7] == 'O' && @array[8] == 'O' ||
          @array[1] == 'O' && @array[4] == 'O' && @array[7] == 'O' ||
          @array[4] == 'O' && @array[2] == 'O' && @array[6] == 'O' ||
          @array[0] == 'O' && @array[3] == 'O' && @array[6] == 'O' ||
          @array[2] == 'O' && @array[5] == 'O' && @array[8] == 'O'
      @winner = 'O'
      return true
    end
    false
  end

  def game_over(winner)
    puts "#{winner} has won. Congratulations!!"
  end
end
