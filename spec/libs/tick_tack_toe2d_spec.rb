require 'rails_helper'
RSpec.describe TickTackToe2d, 'gameplay' do
  context 'should not let' do
    it 'set X twice a row' do
      game = TickTackToe2d.new 
      game.player1_move(Position.new(0,0))
      expect  { game.player1_move(Position.new(1,1)) }.to raise_error(GameplayException)
    end
    it 'set O twice a row' do
      game = TickTackToe2d.new 
      game.player1_move(Position.new(2,2))
      game.player2_move(Position.new(0,0))
      expect  { game.player2_move(Position.new(1,1)) }.to raise_error(GameplayException)
    end
    it 'set stone on occupied field' do
      game = TickTackToe2d.new 
      game.player1_move(Position.new(0,0))
      expect  { game.player2_move(Position.new(0,0)) }.to raise_error(GameplayException, /Field occupied/)
    end
    it 'set stone outside a board' do 
      game = TickTackToe2d.new 
      expect  {game.player1_move(Position.new(3,0))}.to raise_error(GameplayException)
      expect  {game.player2_move(Position.new(0,3))}.to raise_error(GameplayException)
      expect  {game.player1_move(Position.new(3,3))}.to raise_error(GameplayException)
    end
  end
  context 'should let' do
    it 'set O after X' do 
      game = TickTackToe2d.new 
      game.player1_move(Position.new(0,0))
      expect  { game.player2_move(Position.new(1,1)) }.to_not raise_error
    end
    it 'set X after O' do 
      game = TickTackToe2d.new 
      game.player1_move(Position.new(0,0))
      game.player2_move(Position.new(1,2))
      expect  { game.player1_move(Position.new(1,1)) }.to_not raise_error
    end
  end
  context 'detect victory' do
    it 'when horizontal line placed' do 
      game = TickTackToe2d.new 
      game.player1_move(Position.new(0,0))
      game.player2_move(Position.new(1,1))
      game.player1_move(Position.new(1,0))
      game.player2_move(Position.new(2,1))
      game.player1_move(Position.new(2,0))
      expect(game.won?).to be_truthy
    end
    it 'when vertical line placed' do 
      game = TickTackToe2d.new 
      game.player1_move(Position.new(0,0))
      game.player2_move(Position.new(1,1))
      game.player1_move(Position.new(0,1))
      game.player2_move(Position.new(1,2))
      game.player1_move(Position.new(0,2))
      expect(game.won?).to be_truthy
    end
    it 'when diagonal line placed' do 
      game = TickTackToe2d.new 
      game.player1_move(Position.new(0,0))
      game.player2_move(Position.new(0,1))
      game.player1_move(Position.new(1,1))
      game.player2_move(Position.new(0,2))
      game.player1_move(Position.new(2,2))
      expect(game.won?).to be_truthy
    end
  end
  context 'not detect victory' do
    it "when there are no stones on board" do 
      game = TickTackToe2d.new 
      expect(game.won?).to be_falsey
    end
  end
end
