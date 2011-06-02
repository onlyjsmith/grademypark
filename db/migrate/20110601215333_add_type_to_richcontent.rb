class AddTypeToRichcontent < ActiveRecord::Migration
  def self.up
    add_column :richcontents, :type, :string
  end

  def self.down
    remove_column :richcontents, :type
  end
end
