class Board2d 
  def initialize(x,y)
    @height = y
    @width = x
    @board = Array.new(x) { Array.new(y)}
  end
  def place_stone(type, position)
    raise GameplayException.new("Position not valid") unless is_valid_position?(position)
    if field_empty?(position)
      @board[position.x][position.y] = type
    else
      raise GameplayException.new("Field occupied")
    end
  end
  def field_empty?(position) 
    @board[position.x][position.y].nil? 
  end
  def is_valid_position?(position)
    if position.x < 0 or position.x >= @width or position.y < 0 or position.y >= @height 
      return false
    else 
      return true
    end
  end

  def lines_exist?(length)
    lines = false
    @board.each_with_index do |row, x|
      row.each_with_index do |field, y|
        lines = true if line_from_position_exists?(Position.new(x,y), length)
      end
    end
    lines
  end
  def to_s 
    str = "w: #{@width} h: #{@height}\n"
    (0..@width-1).each do |x|
      (0..@height-1).each do |y|
        str << (field_empty?(Position.new(x,y)) ? "-" : @board[x][y])
      end
      str << "|\n"
    end
    str
  end
  def line_from_position_exists?(position, length)
    return false if field_empty?(position)
    first_position = position
    seeked_type = @board[position.x][position.y]
    every_posible_direction.each do |direction|
      found = 1
      last_position = position
      loop do 
        new_position = direction.translate(last_position)
        break unless is_valid_position?(new_position)
        break if field_empty?(new_position)
        if is_valid_position?(new_position)
          if @board[position.x][position.y] == seeked_type
            last_position = new_position
            found += 1 
            if found >= length
              return true
            end
          else
            break
          end
        else
          break
        end
      end
    end
    false
  end

  def every_posible_direction
    offsets = [-1,0,1]
    directions = []
    offsets.product(offsets).each do |offset| ##produces every combination of first, second and third array, which gives 9 directions
      unless offset[0] == 0 and offset[1] == 0
        directions << Direction.new(x: offset[0], y: offset[1])
      end
    end
    directions
  end
end
