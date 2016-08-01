class CreateMatchPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :match_players do |t|
      t.references :match, foreign_key: true
      t.references :player, foreign_key: true
      t.integer :side
      t.string :key

      t.timestamps
    end
  end
end
