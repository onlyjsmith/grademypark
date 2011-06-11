class Country < ActiveRecord::Base
   has_many :places
   has_many :reviews, :through => :places

  # Make sure you clear out the Country table before doing the import
  def self.import
    include HTTParty 
    # data = HTTParty.get("http://protectedplanet.net/api/countries")
    file =  File.open('lib/countries.txt', 'r')
    file.each_line do |line|
      tmp = line.split(",")
      if tmp.length == 5
        new_long_name = tmp[0] + "," + tmp[1]
        Country.new(:long_name => new_long_name, :short_name => tmp[3], :iso_3 => tmp[4]).save
      else
        Country.new(:long_name => tmp[0], :short_name => tmp[2], :iso_3 => tmp[3]).save
      end
    end
    Country.first.destroy
    Country.find_by_short_name("GBR").destroy
  end 
  
  def self.update_all_review_count
    Country.all.each do |c|
      c.update_attributes(:review_count => c.reviews.count)
    end
  end
  
  def self.destroy_all
    Country.all.each {|c| c.destroy}
    Place.all.each {|p| p.update_attributes(:country_id => nil)}
  end
  
  def self.update_everything
    Country.import
    Country.update_all_review_count
  end    
  
  def self.add_and_update_one(place_id)
    country = Country.find(Place.find(place_id).country.id)
    country.review_count += 1
    country.save
  end
  
end
