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
    @results_local = Place.where('name LIKE ?', "%#{params[:search]}%")
    # local_ids = []
    # @results_local.each {|l| local_ids << l.wdpa_id}
    # logger.info local_ids
    all_results_api = Place.search_api(concatenated_search_terms)
    # logger.info all_results_api
    # api_ids = []
    # all_results_api.each {|a| api_ids << a[0]}     
    # logger.info api_ids
    # @results_api = api_ids - local_ids
    @results_api = all_results_api
    @message = 'Sorry. No results for this search. Try harder.' if @results_api.blank? or @results_local.blank?
  end
  
end
