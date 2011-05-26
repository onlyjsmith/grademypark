class StatsController < ApplicationController
  def star_reviews(star)
    @reviews = Review.where("rating >= ?",star).order('rating desc')
  end
  
  
end
