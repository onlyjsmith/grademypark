class AddMorePaFieldsToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :designation, :string
    add_column :places, :reported_area, :float
  end

  def self.down
    remove_column :places, :reported_area
    remove_column :places, :designation
  end
end
