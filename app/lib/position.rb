class Position
  attr_accessor :x
  attr_accessor :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  def to_s
    "#{@x}:#{@y}"
  end

  def self.from_params(params)
    if params.length == 2 
      Position.new(params[:x].to_i, params[:y].to_i)
    else
      Position3d.new(params[:x].to_i, params[:y].to_i, params[:z].to_i)
    end 
  end
end
