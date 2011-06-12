class Richcontent < ActiveRecord::Base
  belongs_to :review
  
  validates_presence_of :review_id, :on => :create, :message => "Needs to be linked to a review"
  # TODO: make the URL checking work
  # validates_format_of :content_url, :with => URI::regexp(%w(http https)), :message => "Doesn't look like a real web address"
  # Outline for content_type
  # 1 Picture/image/photo
  # 2 Blog/user-generated
  # 3 Commercial

  def self.fix_all_prefixes
    Richcontent.all.each do |richcontent|
      if richcontent.content_url.scan(/https?:\/\//).empty?
        richcontent.prefix = "http://"
      else
        split = richcontent.content_url.split("://")
        richcontent.prefix = split[0] + "://"
        richcontent.content_url = split[1]
      end 
      richcontent.save
    end
  end
  
end
