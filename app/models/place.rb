class Place < ActiveRecord::Base
  has_many :reviews
  has_many :users, :through => :reviews   
  has_many :richcontents, :through => :reviews
  has_many :ratings
  has_many :raters, :through => :ratings, :source => :users
  
  belongs_to :country
  
  
  include HTTParty

  
  def self.search_api(search)
    #go off to ProtectedPlanet API and return results
    # debugger
    results = Place.get("http://protectedplanet.net/api/search?q=#{search}", :format => :json)
    # results = RestClient.get "http://protectedplanet.net/api/search?q=#{search}", {:accept => :json}
    data = []
    # results.parsed_response.
    results[0].each do |r|
      data << [r['site']['id'], r['site']['cached_slug']]
    end
    return data
  end
  
  def self.find_name_from_id(id)
    result = Place.get("http://protectedplanet.net/api2/sites/#{id}")['official']['NAME']
  end
  
  def self.get_boundary(wdpa_id)
    data = Place.get("http://protectedplanet.net/api2/sites/#{wdpa_id}")['official']['GEOM']
  end
  
  def self.get_info(wdpa_id)
  # info[0] is reported area
  # info[1] is designation(english)
  # info[2] is country(iso_3)
  # info[3] is name of PA
    response = Place.get("http://protectedplanet.net/api2/sites/#{wdpa_id}")
    @data = []
    @data << response['official']['REP_AREA']
    @data << response['official']['DESIG_ENG']
    @data << response['official']['COUNTRY']
    @data << response['official']['NAME']
    @data
  end

  
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
      place.update_attributes(:review_count => place.reviews.count)
    end
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

  def self.update_avg_rating
    Place.all.each do |place|
      if place.total_rating == 0
        place.update_attributes(:avg_rating => 0)        
      else
        avg_rating = place.total_rating / place.review_count
        place.update_attributes(:avg_rating => avg_rating)
      end
    end
  end
  
  # TODO: No idea if this works properly - think not  
  def self.highest_reviewed(limit)
    Place.find(:all, :limit => limit, :order => 'avg_rating DESC')
  end
  
  # TODO: No idea if this works properly - think not  
  def self.most_reviewed
    Place.find(:all, :order => 'review_count DESC')
  end
  
  def self.remove_place(place_id)
    Review.find_all_by_place_id(place_id).each do |review|
      review.destroy
    end
    Place.find(place_id).destroy
  end

  def self.add_missing_country_data
    list = Place.find_all_by_country_id(nil)
    list.each do |place|
      print "Found #{place.name}..."
      place_country = Place.get("http://protectedplanet.net/api2/sites/#{place.wdpa_id}")['official']['COUNTRY']
      country_id = Country.find_by_short_name(place_country).id
      place.update_attributes(:country_id => country_id)
      puts "Updated #{place.name} to #{country_id}"
    end
  end 
  
  def self.add_missing_place_data
    list1 = Place.find_all_by_designation(nil)
    list2 = Place.find_all_by_reported_area(nil)
    list = (list1 + list2).uniq
    list.each do |place|
      info = Place.get_info(place.wdpa_id)
      place.update_attributes(:designation => info[1], :reported_area => info[0])
    end
  end
  
  def self.update_everything
    Place.add_missing_place_data
    Place.add_missing_country_data
    Place.update_review_count
    Place.update_total_rating
    Place.update_avg_rating    
  end
  
  def self.update_all_scores
    Place.update_review_count
    Place.update_total_rating
    Place.update_avg_rating    
  end  
  
  def self.add_and_update_one(review_id)
    review = Review.find(review_id)
    place = review.place
    place.review_count += 1
    place.total_rating += review.rating
    place.avg_rating = (place.total_rating / place.review_count)
    place.save
    puts "Place #{place.id} scores updated"
    
  end
end


