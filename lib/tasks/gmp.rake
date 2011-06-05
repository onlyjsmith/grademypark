namespace :gmp do
  desc "get up and running"
  task :build  => :environment do
     Rake::Task["gmp:destroy_users"].invoke
  end
  
  desc "fill in missing pieces"
  task :import => :environment do
    Country.import
    Country.update_review_counts
    Place.add_missing_place_data
    Place.add_missing_country_data
    Place.update_review_count
    Place.update_total_rating
    Place.update_avg_rating
  end
     
  
end