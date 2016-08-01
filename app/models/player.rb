class Player < ApplicationRecord
  validates :uniq_hash, uniqueness: true
  before_create :set_hash
  def set_hash
    begin 
      self.uniq_hash = IdGenerator.generate 
    end until Player.where(:uniq_hash => self.uniq_hash).empty?
  end
end
