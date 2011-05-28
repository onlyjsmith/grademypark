class Place < ActiveRecord::Base
  has_many :reviews
  has_many :users, :through => :reviews
  
  include HTTParty
  format :json
  
  def self.search(search)
    #go off to API and return results
    # format :json
    results = Place.get("http://protectedplanet.net/api/search?q=#{search}", :format => :json)
    # debugger
    @ids = []
    results[0].each do |r|
      @ids << [r['site']['id'], r['site']['cached_slug']]
    end
    return @ids
  end
  
  def self.find_name_from_id(id)
    result = Place.get("http://protectedplanet.net/api2/sites/#{id}")['official']['NAME']
  end
  
  #This doesn't do anything logical!
  def self.highest_rated(limit)
    places = []
    Review.find(:all, :limit => limit, :order => "wildness DESC").each do |review|
      places << review.place
    end
    places
  end
  
  def calculate_avg_ratings
      # Add field to model, and calculate average scores based on reviews!  
  end
  
  def self.most_reviewed
    Place.find(:all, :limit => 10, :order => 'review_count DESC')
  end
  
end


