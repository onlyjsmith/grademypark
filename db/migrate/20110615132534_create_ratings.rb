class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :review_id
      t.integer :aspect
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
