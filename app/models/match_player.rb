class MatchPlayer < ApplicationRecord
  belongs_to :match
  belongs_to :player
  
  before_create :set_hash
  def set_hash
    begin 
      self.key = IdGenerator.generate 
    end until MatchPlayer.where(:key => self.key).empty?
  end
  def set_stone(position)
    begin
      raise GameplayException.new("Can't play this match") if  self.match.ended
      if self.side == 1
        method = "player1_move"
      else
        method = "player2_move"
      end
      position = Position.from_params(position)
      self.match.get_board.send(method, position)
      self.match.last_position = position.to_s
      self.match.save
    rescue GameplayException => ex
      render json: {:error => ex.message} 
    end
  end
  def get_state
    board = self.match.get_board
    {
      turn: board.turn,
      board: board,
      ended: self.match.ended ? 1 : 0,
      player: self.side == 1 ? "x" : "o" 
    }
  end
end
