class StatsController < ApplicationController
  def star_reviews(star)
    @reviews = Review.find_all_by_rating.where("rating >= ?",star)
  end
end
