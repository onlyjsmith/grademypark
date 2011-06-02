class RenameRichcontentType < ActiveRecord::Migration
  def self.up
    rename_column :richcontents, :type, :content_type
  end

  def self.down
    rename_column :richcontents, :content_type, :type
  end
end