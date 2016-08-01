class Match < ApplicationRecord
  has_many :match_players
  before_save :store_board
  before_update do
    if @_board.won? 
      self.ended = true
    end   
  end
  after_find do
    @_board = Marshal::load(self.board) if self.board
  end
  before_create :prepare_board
  def prepare_board 
    @_board = TickTackToe3d.new unless @_board 
    store_board
  end
  def get_state 
    @_board.get_board.to_s
  end
  def get_board
    @_board
  end
  def store_board
    self.board = Marshal::dump(@_board)
  end
  def player_x
    self.match_players.where(side: 1).first
  end
  def player_o
    self.match_players.where(side: 0).first
  end

  def player_x=(player_id)
    self.match_players.where(side: 1).destroy_all
    self.match_players.new(:player_id => player_id, :side => 1)
  end
  def player_o=(player_id)
    self.match_players.where(side: 0).destroy_all
    self.match_players.new(:player_id => player_id, :side => 0)
  end
  def get_last_position
    return nil unless self.last_position
    pos = self.last_position.split ':'
    return {
      x: pos[0], 
      y: pos[1], 
      z: pos[2]
    }
  end
  def randomize
    side = self.get_board.turn
    position = Position.from_params({:x => rand(0..3), :y => rand(0..3), :z => rand(0..3)})
    self.last_position = position.to_s
    if side == "o"
      self.get_board.player2_move(position)
    else
      self.get_board.player1_move(position)
    end
    self.save!
  end
end
