class AddPlaceIdToReview < ActiveRecord::Migration
  def self.up
    add_column :reviews, :place_id, :integer
  end

  def self.down
    remove_column :reviews, :place_id
  end
end
