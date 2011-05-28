class AddAvgRatingToPlace < ActiveRecord::Migration
  def self.up
    add_column :places, :avg_rating, :integer
  end

  def self.down
    remove_column :places, :avg_rating
  end
end
