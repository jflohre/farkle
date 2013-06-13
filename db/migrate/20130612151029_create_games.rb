class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.boolean :winner
      t.text :preferences
      
      t.timestamps
    end
  end
end
