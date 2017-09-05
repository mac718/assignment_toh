require 'pry'

def initialize_board(tower_height)
  board = [(1..tower_height).to_a, [], []]
end

def make_move(board, move, tower_height)
  board[move[1]].unshift(board[move[0]].shift)
  display_board(board, tower_height)
end

def display_board(board, tower_height)
  peg1 = []

  peg2 =  []

  peg3 = []

  (tower_height-board[0].length).times { peg1 << (' ' * tower_height) }
  
  board[0].each do |disc|
      peg1 << 'o' * disc 
  end 

  (tower_height-board[1].length).times { peg2 << (' ' * tower_height) } 

  board[1].each do |disc|
      peg2 << 'o' * disc 
  end 

  (tower_height-board[2].length).times { peg3 << (' ' * tower_height) }

  board[2].each do |disc|
      peg3 << 'o' * disc 
  end 

  tower_height.times { |i| puts peg1[i] + ' ' + peg2[i] + ' ' + peg3[i] }
end

def valid_move?(tower_height, move, board)
  move.length == 3 && (1..tower_height).include?(move[0].to_i) && 
  move[1] == ',' && (1..tower_height).include?(move[2].to_i) &&
  (board[move[2].to_i - 1].empty? || board[move[0].to_i - 1][0] < board[move[2].to_i - 1][0]) &&
  !board[move[0].to_i - 1].empty?
end

def win?(board, tower_height)
  board[1..2].any? { |peg| peg.size == tower_height }
end

puts "Welcome to Tower of Hanoi!"
puts "Instructions:"
puts "Enter where you'd like to move from and to"
puts "in the format '1,3'. Enter 'q' to quit."
puts "Current Board:"

puts "Specify tower height"
tower_height = gets.chomp.to_i 

board = initialize_board(tower_height)
display_board(board, tower_height)

loop do 
  puts "Enter move:"
  move = gets.chomp
  break if move.downcase == 'q'
  while !valid_move?(tower_height, move, board)
    puts "Invalid move, try again:"
    move = gets.chomp
    break if move.downcase == 'q'
  end
  break if move.downcase == 'q'
  move = [move[0].to_i - 1, move[2].to_i - 1]
  make_move(board, move, tower_height)
  break if win?(board, tower_height)
end

win?(board, tower_height) ? (puts "You win!") : (puts "Thanks for playing!")
