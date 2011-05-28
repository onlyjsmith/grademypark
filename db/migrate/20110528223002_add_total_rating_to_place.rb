class AddTotalRatingToPlace < ActiveRecord::Migration
  def self.up
    add_column :places, :total_rating, :integer
  end

  def self.down
    remove_column :places, :total_rating
  end
end
