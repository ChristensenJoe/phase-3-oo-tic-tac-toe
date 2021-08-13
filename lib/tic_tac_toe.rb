require "pry"

class TicTacToe
  attr_reader :board

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]

  def initialize
    @board = []
    9.times do |i|
      @board.push(" ")
    end
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    (index >= 0 && index <= 9) && (!position_taken?(index))
  end

  def turn_count
    @board.count { |x| x != " " }
  end

  def current_player
    if turn_count % 2 == 1
      "O"
    else
      "X"
    end
  end

  def turn
    player = current_player
    puts "Player #{player}, please choose a move (1-9)."
    move = gets
    move_index = input_to_index(move)
    if valid_move?(move_index)
      @board[move_index] = "#{player}"
      display_board
    else
      puts "Invalid move. Try again."
      turn
    end
  end

  def won?
    x_arr = ["X", "X", "X"]
    o_arr = ["O", "O", "O"]

    winning_arr = []

    WIN_COMBINATIONS.each do |win_combo|
      arr = []
      win_combo.each do |num|
        arr << @board[num]
      end

      if (arr - x_arr).empty? || (arr - o_arr).empty?
        winning_arr = win_combo
      end
    end

    if winning_arr.empty?
      false
    else
      winning_arr
    end
  end

  def full?
    !@board.any? { |position| position == " " }
  end

  def draw?
    if won?.is_a? Array
      return false
    end
    full? && !won?
  end

  def over?
    (won?.is_a? Array) || full?
  end

  def winner
    win_indexes = won?
    if !won?
      nil
    else
      if @board[win_indexes[0]] == "X"
        "X"
      else
        "O"
      end
    end
  end

  def play
    while !over?
      puts turn

      if won? || draw?
        break
      end
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
