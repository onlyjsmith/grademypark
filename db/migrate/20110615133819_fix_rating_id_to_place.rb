class FixRatingIdToPlace < ActiveRecord::Migration
  def self.up
    rename_column :ratings, :review_id, :place_id
  end

  def self.down
    rename_column :ratings, :place_id, :review_id
  end
end