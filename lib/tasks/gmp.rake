namespace :gmp do
  desc "get up and running"
  task :build  => :environment do
     Rake::Task["gmp:import"].invoke
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
    puts "Has added bunches of stuff"
  end
  
  desc "update_place_scores"
  task :update_place_scores  => :environment do
    Place.update_review_count
    Place.update_total_rating
    Place.update_avg_rating
    puts "Has updated scores for Places successfully"
  end
  
end