class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :long_name
      t.string :short_name
      t.integer :iso_3
      t.integer :pa_count

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
