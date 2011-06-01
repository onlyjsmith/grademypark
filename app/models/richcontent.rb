class Richcontent < ActiveRecord::Base
  belongs_to :review
  
  validates_presence_of :review_id, :on => :create, :message => "Needs to be linked to a review"
  
  # Outline for content_type
  # 1 Picture/image/photo
  # 2 Blog/user-generated
  # 3 Commercial
  
end
