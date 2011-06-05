class Country < ActiveRecord::Base
   has_many :places
   has_many :reviews, :through => :places

  def self.import
    destroy_all
    puts "Emptied DB"
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
  
  def self.update_review_counts
    Country.all.each do |c|
      c.update_attributes(:review_count => c.reviews.count)
    end
  end
  
  def self.destroy_all
    Country.all.each {|c| c.destroy}
  end
  
  
end
