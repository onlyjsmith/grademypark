class AddPrefixToRichcontents < ActiveRecord::Migration
  def self.up
    add_column :richcontents, :prefix, :string
  end

  def self.down
    remove_column :richcontents, :prefix
  end
end
