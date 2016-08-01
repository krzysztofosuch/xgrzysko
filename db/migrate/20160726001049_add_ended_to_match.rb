class AddEndedToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :ended, :boolean
  end
end
