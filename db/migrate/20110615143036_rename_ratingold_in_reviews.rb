class RenameRatingoldInReviews < ActiveRecord::Migration
  def self.up
    rename_column :reviews, :rating_old, :rating
  end

  def self.down
    rename_column :reviews, :rating, :rating_old
  end
end