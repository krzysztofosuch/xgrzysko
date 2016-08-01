class Api::GameplayController < ApplicationController
  skip_before_action :verify_authenticity_token
  rescue_from GameplayException, with: :gameplay_exception
  before_action do
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
  def set_stone
    sleep(2)
    set_game
    @game.set_stone params[:position]
    render :json =>{:ok => true}
  end
  def get_state
    set_game
    render json: @game.get_state
  end
  private 
  def set_game
    @game = MatchPlayer.where(:key => params[:key]).first
  end

  def stone_parameters
    params.require(:position).permit(:x, :y, :z)
  end
  def gameplay_exception(exception)
    render :json => {:error => exception.message }, :status => 400
  end
end
