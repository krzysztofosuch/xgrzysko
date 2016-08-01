class AddLastPositionToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :last_position, :string
  end
end
