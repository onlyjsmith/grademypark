class HomeController < ApplicationController

  def index
    @places = Place.most_reviewed
    @places = Place.highest_reviewed(10)
    @reviewers = User.all(:limit => 10)
    @recent_reviews = Review.all(:limit => 10, :order => 'updated_at DESC')
    @random_site = "Lake Naivasha"
    @top_countries = Country.all(:limit => 4, :order => 'review_count DESC')
    respond_to do |format|
      format.html # index.html.erb
      # format.xml  { render :xml => @places }
    end
  end
  
  def search
    # @results = ["Search results", "All in here"]
    concatenated_search_terms = params[:search].split(" ").join("%20")
    @results = Place.search(concatenated_search_terms)
    @message = 'Sorry. No results for this search. Try harder.' if @results.blank?
  end
  
end
