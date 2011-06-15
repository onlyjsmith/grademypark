class Rating < ActiveRecord::Base
  # todo: make this model not have the same name as the current rating in reviews model - for associations...
  attr_accessible :value

  belongs_to :place
  belongs_to :user
end
