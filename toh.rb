require 'pry'

def initialize_board(tower_height)
  board = [(1..tower_height).to_a, [], []]
end

def make_move(board, move)
  board[move[1]].unshift(board[move[0]].shift)
end

def display_board(board)
  p board
end

def win?(board, tower_height)
  board.any? { |peg| peg.size == tower_height }
end

puts "Specify tower height"
tower_height = gets.chomp.to_i 

board = initialize_board(tower_height)

loop do 
  puts "Enter move:"
  move = gets.chomp
  while move.length != 3 || !(1..tower_height).include?(move[0].to_i)  || move[1] != ',' || !(1..tower_height).include?(move[2].to_i)
    puts "Invalid move, try again:"
    move = gets.chomp
  end
  move = [move[0].to_i - 1, move[2].to_i - 1]
  if board[move[1]].empty?
    make_move(board, move)
    display_board(board)
  elsif board[move[0]][0] > board[move[1]][0]
    puts "invalid move"
    break 
  else
    make_move(board, move)
    display_board(board)
  end
  break if win?(board, tower_height)
end
