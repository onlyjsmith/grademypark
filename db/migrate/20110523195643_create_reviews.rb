class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :rating
      t.integer :wildness
      t.integer :management
      t.string :review_text
      t.string :contact_details
      t.integer :review_value

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
