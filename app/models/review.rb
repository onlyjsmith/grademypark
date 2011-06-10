class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  has_many :richcontents

  # validates_associated :places
  validates_numericality_of :rating, :only_integer => true, :greater_than => 0, :less_than => 6, :message => 'Between 1 and 5'
  validates_numericality_of :wildness, :only_integer => true, :greater_than => 0, :less_than => 6, :message => 'Between 1 and 5'
  validates_numericality_of :management, :only_integer => true, :greater_than => 0, :less_than => 6, :message => 'Between 1 and 5'
  validates_presence_of :review_text, :on => :create, :message => "can't be blank"
  validates_presence_of :place_id, :on => :create, :message => "can't be blank - please search from home page"
end
