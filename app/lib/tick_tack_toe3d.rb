class TickTackToe3d
  def initialize
    @board = Board3d.new 4,4,4
    @turn = 0
  end

  def player1_move(position)
    if @turn == 0
      self.place_stone "x", position
      @turn = 1
    else
      raise GameplayException.new("Wrong turn")
    end    
  end
  def turn 
    @turn == 0 ? "x" : "o"
  end 
  def player2_move(position)
    if @turn == 1
      self.place_stone "o", position
      @turn = 0
    else
      raise GameplayException.new("Wrong turn")
    end    
  end

  def place_stone(type, position) 
    @board.place_stone(type, position)
  end
  def get_board
    @board
  end
  def won?
    @board.lines_exist?(4)
  end
  def winning_line
    @board.winning_line(4)
  end
end
