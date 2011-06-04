class User < ActiveRecord::Base
  has_many :reviews
  has_many :places, :through => :reviews

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["user_info"]["name"]
    end
  end
  
end
