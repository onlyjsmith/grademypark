class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  has_many :richcontents
  has_many :starratings
  has_many :starraters, :through => :starratings, :source => :users


  # validates_associated :places
  validates_numericality_of :rating, :only_integer => true, :greater_than => 0, :less_than => 6, :message => 'Between 1 and 5'
  validates_numericality_of :wildness, :only_integer => true, :greater_than => 0, :less_than => 6, :message => 'Between 1 and 5'
  validates_numericality_of :management, :only_integer => true, :greater_than => 0, :less_than => 6, :message => 'Between 1 and 5'
  validates_presence_of :review_text, :on => :create, :message => "can't be blank"
  validates_presence_of :place_id, :on => :create, :message => "can't be blank - please search from home page"


  def average_rating
    @value = 0
    self.ratings.each do |rating|
      @value = @value + rating.value
    end
    @total = self.ratings.size
    @value.to_f / @total.to_f
  end


end
