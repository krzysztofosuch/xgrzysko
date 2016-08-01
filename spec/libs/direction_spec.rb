require 'rails_helper'
RSpec.describe Direction, 'direction' do 
  it 'should not change position when none changes provided' do 
    d = Direction.new(Hash.new)
    position = Position.new(0,0)
    new_position = d.translate(position)
    expect(new_position.x).to eq(0)
    expect(new_position.y).to eq(0)
  end
  it 'should change y from 0 to 1 when y:1 offet provided' do 
    d = Direction.new({y: 1})
    position = Position.new(0,0)
    new_position = d.translate(position)
    expect(new_position.x).to eq(0)
    expect(new_position.y).to eq(1)
  end
  it 'should change y and y from 0 to 1 when offet x:1, y:1 provided' do 
    d = Direction.new({y: 1, x:1})
    position = Position.new(0,0)
    new_position = d.translate(position)
    expect(new_position.x).to eq(1)
    expect(new_position.y).to eq(1)
  end
  it 'should change y to -1 and leave x unchanged when offset = y:-1, x:0' do 
    d = Direction.new({y: -1, x:0})
    position = Position.new(0,0)
    new_position = d.translate(position)
    expect(new_position.x).to eq(0)
    expect(new_position.y).to eq(-1)
  end
  it 'should raise error when offset doesnt match position' do 
    d = Direction.new({y: -1, x:0, z:0})
    position = Position.new(0,0)
    expect {d.translate(position)}.to raise_error(RuntimeError)
  end
end

