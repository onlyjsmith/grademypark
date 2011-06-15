class RenameRatingsTable < ActiveRecord::Migration
  def self.up
    rename_table :ratings, :starratings
  end

  def self.down
    rename_table :starratings, :ratings
  end
end