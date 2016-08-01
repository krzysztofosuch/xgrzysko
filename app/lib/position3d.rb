class Position3d < Position
  attr_accessor :z
  def initialize(x,y,z)
    super(x,y)
    @z = z
  end

  def to_s
    "#{self.x}:#{self.y}:#{self.z}"
  end
end
