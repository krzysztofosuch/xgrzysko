class Board3d 
  def initialize(x,y,z)
    @height = y
    @width = x
    @depth = z
    @board = Array.new(x) { Array.new(y) { Array.new(z) } }
  end
  def place_stone(type, position)
    raise GameplayException.new("Position not valid") unless is_valid_position?(position)
    if field_empty?(position)
      @board[position.x][position.y][position.z] = type
    else
      raise GameplayException.new("Field occupied")
    end
  end
  def field_empty?(position) 
    @board[position.x][position.y][position.z].nil? 
  end
  def is_valid_position?(position)
    if position.x < 0 or position.x >= @width or position.y < 0 or position.y >= @height or position.z < 0 or position.z >= @depth 
      return false
    else 
      return true
    end
  end

  def lines_exist?(length)
    lines = false
    @board.each_with_index do |row, x|
      row.each_with_index do |slice, y|
        slice.each_with_index do |field, z|
          if line_from_position_exists?(Position3d.new(x,y,z), length)
            return true
          end
        end
      end
    end
    return false
  end


  def winning_line(length)
    lines = false
    @board.each_with_index do |row, x|
      row.each_with_index do |slice, y|
        slice.each_with_index do |field, z|
          line = line_from_position(Position3d.new(x,y,z), length)
          return line if line
        end
      end
    end
    return false
  end

  def to_s 
    ""
  end
  def line_from_position(position, length)
    return false if field_empty?(position)
    first_position = position
    seeked_type = @board[position.x][position.y][position.z]
    every_posible_direction.each do |direction|
      found = 1
      last_position = position
      positions_in_line = [position]
      loop do 
        new_position = direction.translate(last_position)
        break unless is_valid_position?(new_position)
        break if field_empty?(new_position)
        if is_valid_position?(new_position)
          if @board[new_position.x][new_position.y][new_position.z] == seeked_type
            last_position = new_position
            found += 1 
            positions_in_line << new_position
            if found >= length
              return positions_in_line 
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
  def line_from_position_exists?(position, length)
    return false if field_empty?(position)
    first_position = position
    seeked_type = @board[position.x][position.y][position.z]
    puts "Looking for type" << seeked_type
    every_posible_direction.each do |direction|
      found = 1
      last_position = position
      loop do 
        new_position = direction.translate(last_position)
        break unless is_valid_position?(new_position)
        break if field_empty?(new_position)
        if is_valid_position?(new_position)
          if @board[new_position.x][new_position.y][new_position.z] == seeked_type
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
    offsets.product(offsets, offsets).each do |offset| ##produces every combination of first, second and third array, which gives 9 directions
      unless offset[0] == 0 and offset[1] == 0 and offset[2] == 0
        directions << Direction.new(x: offset[0], y: offset[1], z: offset[2])
      end
    end
    directions
  end

  def get_fields
    @board
  end
end
