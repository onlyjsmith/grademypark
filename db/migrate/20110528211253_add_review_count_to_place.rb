class AddReviewCountToPlace < ActiveRecord::Migration
  def self.up
    add_column :places, :review_count, :integer
  end

  def self.down
    remove_column :places, :review_count
  end
end
