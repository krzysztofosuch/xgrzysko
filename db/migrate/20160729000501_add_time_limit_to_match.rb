class AddTimeLimitToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :timeLimit, :integer
  end
end
