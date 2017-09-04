require 'pry'

def initialize_board(tower_height)
  board = [(1..tower_height).to_a, [], []]
end

def make_move(board, move, tower_height)
  board[move[1]].unshift(board[move[0]].shift)
  display_board(board, tower_height)
end

def display_board(board, tower_height)
  peg1 = [[]]

  peg2 =  [[]]

  peg3 = [[]]


  board[0].each do |disc|
      peg1[0] << 'o' * disc 
  end 

  (tower_height-board[0].length).times { peg1[0].unshift(' ' * tower_height) }

  board[1].each do |disc|
      peg2[0] << 'o' * disc 
  end 

  (tower_height-board[1].length).times { peg2[0].unshift(' ' * tower_height) }


  board[2].each do |disc|
      peg3[0] << 'o' * disc 
  end 

  (tower_height-board[2].length).times { peg3[0].unshift(' ' * tower_height) }

  tower_height.times { |i| puts peg1[0][i] + ' ' + peg2[0][i] + ' ' + peg3[0][i] }

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
display_board(board, tower_height)

loop do 
  puts "Enter move:"
  move = gets.chomp
  while !valid_move?(tower_height, move, board)
    puts "Invalid move, try again:"
    move = gets.chomp
  end
  move = [move[0].to_i - 1, move[2].to_i - 1]
  make_move(board, move, tower_height)
  break if win?(board, tower_height)
end

puts "You win!"
