class AddScoreToScore < ActiveRecord::Migration
  def change
    add_column :scores, :score, :integer
  end
end
