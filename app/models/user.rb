class User < ActiveRecord::Base
  has_many :reviews
  has_many :places, :through => :reviews
  has_many :ratings
  has_many :rated_places, :through => :ratings, :source => :places


  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["user_info"]["name"] || "No name"
    end
  end
  
end
