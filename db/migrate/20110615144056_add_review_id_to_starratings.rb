class AddReviewIdToStarratings < ActiveRecord::Migration
  def self.up
    add_column :starratings, :review_id, :integer
  end

  def self.down
    remove_column :starratings, :review_id
  end
end
