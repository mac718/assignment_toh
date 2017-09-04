require 'pry'

def initialize_board(tower_height)
  board = [(1..tower_height).to_a, [], []]
end

def make_move(board, move)
  board[move[1]].unshift(board[move[0]].shift)
  display_board(board)
end

def display_board(board)
  p board
end

def valid_move?(tower_height, move, board)
  move.length == 3 && (1..tower_height).include?(move[0].to_i) && 
  move[1] == ',' && (1..tower_height).include?(move[2].to_i) &&
  (board[move[2].to_i - 1].empty? || board[move[0].to_i - 1][0] < board[move[2].to_i - 1][0])
end

def win?(board, tower_height)
  board.any? { |peg| peg.size == tower_height }
end

puts "Specify tower height"
tower_height = gets.chomp.to_i 

board = initialize_board(tower_height)
display_board(board)

loop do 
  puts "Enter move:"
  move = gets.chomp
  while !valid_move?(tower_height, move, board)
    puts "Invalid move, try again:"
    move = gets.chomp
  end
  move = [move[0].to_i - 1, move[2].to_i - 1]
  make_move(board, move)
  break if win?(board, tower_height)
end

puts "You win!"
