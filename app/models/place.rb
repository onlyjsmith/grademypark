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
  

  def self.update_total_rating
    Place.all.each do |place|
      total = 0
      place.reviews.all.each do |review|
        total += review.rating 
      end
      place.total_rating = total
      place.save
    end
  end

  def self.get_boundary(wdpa_id)
    data = Place.get("http://protectedplanet.net/api2/sites/#{wdpa_id}")['official']['GEOM']
  end
  
  # def self.get_kml(wdpa_id)
  #   data = Place.get("http://protectedplanet.net/api2/sites/#{wdpa_id}")['official']['GEOM']
  #   trim = data
  #   # trim = data[10..-1]
  #   parser = RGeo::WKRep::WKTParser.new(:support_ewkt => :true)
  #   parser.parse(trim)
  # end
  
  
  def self.decode(wdpa_id)
    @data = Place.get("http://protectedplanet.net/api2/sites/#{wdpa_id}")['official']['GEOM']
    array = @data.slice(25..-4).split(",")
    poly_string = ""
    first_set = array.first.split(" ")
    poly_centre = first_set[1]+","+first_set[0]
    array.each do |pair|
      values = pair.split(' ')
      poly_string += "new google.maps.LatLng(" + values[1] +"," + values[0] + ")," 
    end
    output = [poly_string[0..-2], poly_centre]
  end
      
  def self.update_review_count
    Place.all.each do |place|
      place.review_count = place.reviews.count 
      place.save
    end
  end
  
  def self.update_avg_rating
    Place.all.each do |place|
      place.avg_rating = place.total_rating / place.review_count
      place.save
    end
  end
  
  def self.highest_reviewed(limit)
    Place.find(:all, :limit => limit, :order => 'avg_rating DESC')
  end
  
  
  def self.most_reviewed
    Place.find(:all, :order => 'review_count DESC')
  end
  
  def self.remove_place(place_id)
    Review.find_all_by_place_id(place_id).each do |review|
      review.destroy
    end
    Place.find(place_id).destroy
  end
  
end


