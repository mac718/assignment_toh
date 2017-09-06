class TowerOfHanoi
  def initialize(tower_height)
    @tower_height = tower_height
    @board = [(1..@tower_height).to_a, [], []]
  end

  def make_move(move)
    @board[move[1]].unshift(@board[move[0]].shift)
    display_board
  end

  def display_board
    peg1, peg2, peg3 = [], [], []

    (@tower_height - @board[0].length).times { peg1 << (' ' * @tower_height) }
    @board[0].each { |disc| peg1 << 'o' * disc }
         
    (@tower_height - @board[1].length).times { peg2 << (' ' * @tower_height) } 
    @board[1].each { |disc| peg2 << 'o' * disc }
        
    (@tower_height - @board[2].length).times { peg3 << (' ' * @tower_height) }
    @board[2].each { |disc| peg3 << 'o' * disc }
         
    @tower_height.times { |i| puts peg1[i].ljust(@tower_height) + ' ' + peg2[i].ljust(@tower_height) +  
      ' ' + peg3[i].ljust(@tower_height) }

    3.times { |i| print "#{i + 1}".center(@tower_height) + ' '}
  end

  def valid_move?(move)
    move.length == 3 && (1..@tower_height).include?(move[0].to_i) && 
    move[1] == ',' && (1..@tower_height).include?(move[2].to_i) &&
    (@board[move[2].to_i - 1].empty? || (!@board[move[0].to_i - 1].empty? && 
      @board[move[0].to_i - 1][0] < @board[move[2].to_i - 1][0])) &&
    !@board[move[0].to_i - 1].empty?
  end

  def win?
    @board[1..2].any? { |peg| peg.size == @tower_height }
  end

  def play
    loop do 
      puts "**************************"
      puts "Welcome to Tower of Hanoi!"
      puts "**************************"
      puts "Instructions:"
      puts "Enter where you'd like to move from and to"
      puts "in the format '1,3'. Enter 'q' to quit."
      puts "Current Board:"
      display_board
      puts "Enter move >"
      move = gets.chomp
      break if move.downcase == 'q'
      while !valid_move?(move)
        puts "Invalid move, try again >"
        move = gets.chomp
        break if move.downcase == 'q'
      end
      break if move.downcase == 'q'
      move = [move[0].to_i - 1, move[2].to_i - 1]
      make_move(move)
      break if win?
    end
    win? ? (puts "You win!") : (puts "Thanks for playing!")
  end
end

