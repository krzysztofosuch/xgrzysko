class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :set_stone
  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
    raise
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
#  def update
#    respond_to do |format|
#      if @match.update(match_params)
#        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
#      else
#        format.html { render :edit }
#      end
#    end
#  end

  # DELETE /matches/1
  # DELETE /matches/1.json
#  def destroy
#    @match.destroy
#    respond_to do |format|
#      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
#    end
#  end
  def set_stone
    set_match 
    raise GameplayException.new("Can't play this match") if  @match.ended
    side = @match.get_board.turn
    puts side
    position = Position.from_params(params.fetch(:position).permit(:x, :y, :z))
    @match.last_position = position.to_s
    if side == "o"
      @match.get_board.player2_move(position)
    else
      @match.get_board.player1_move(position)
    end
    @match.save!
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.fetch(:match).permit(:player_o, :player_x)
    end
end
