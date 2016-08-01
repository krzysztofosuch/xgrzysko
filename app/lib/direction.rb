class Direction
  def initialize(definition)
    @coordinates = definition 
  end

  def translate(position)
    after_translation = position.clone
    @coordinates.each do |key, value|
      if position.respond_to?(key)
        after_translation.send("#{key}=".to_sym, position.send(key.to_sym).to_i+value)
      else
        raise "position doesnt match translation coordinates"
      end  
    end
    puts ActiveSupport::JSON.encode(["aaaaa", position,self , after_translation])
    after_translation
  end
end
