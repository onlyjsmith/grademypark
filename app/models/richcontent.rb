class Richcontent < ActiveRecord::Base
  belongs_to :review
  
  validates_presence_of :review_id, :on => :create, :message => "Needs to be linked to a review"
end
