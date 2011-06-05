class AddReviewCountToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :review_count, :integer
  end

  def self.down
    remove_column :countries, :review_count
  end
end
