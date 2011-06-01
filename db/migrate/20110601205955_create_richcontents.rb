class CreateRichcontents < ActiveRecord::Migration
  def self.up
    create_table :richcontents do |t|
      t.string :content_name
      t.string :content_url
      t.integer :review_id

      t.timestamps
    end
  end

  def self.down
    drop_table :richcontents
  end
end
