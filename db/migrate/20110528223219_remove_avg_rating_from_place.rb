class RemoveAvgRatingFromPlace < ActiveRecord::Migration
  def self.up
    remove_column :places, :avg_rating
  end

  def self.down
  end
end
