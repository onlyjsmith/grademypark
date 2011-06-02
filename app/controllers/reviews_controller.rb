class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.xml
  def index
    @reviews = Review.all
    Place.update_total_rating
    Place.update_avg_rating
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = Review.find(params[:id])  
    wdpa_id = Place.find_by_wdpa_id(@review.place.wdpa_id).wdpa_id
    data = Place.decode(wdpa_id)
    @poly_string = data[0]
    @poly_centre = data[1]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml
  def new
    logger.info("PARAMS: #{params.inspect}")
    @review = Review.new
    @review.user_id = 1
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end
  
  def new_from_search
    logger.info("PARAMS: #{params.inspect}")
    @review = Review.new
    @review.user_id = 1
    
    if Place.find_by_wdpa_id(params[:id]).nil?
      then Place.create(:wdpa_id => (params[:id]), :name => Place.find_name_from_id(params[:id]), :review_count => 1, :total_rating => 1, :avg_rating => 1)
      # Place.update_total_rating
      # Place.update_avg_rating
    end
    place = Place.find_by_wdpa_id(params[:id])
    
    
    # place = Place.find_or_create_by_wdpa_id(params[:id]) {|u| u.name = Place.find_name_from_id(params[:id]), u.review_count = 1}
    
    
    @review.place_id = place.id
    
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @review = Review.new(params[:review])

    respond_to do |format|
      if @review.save
        place = @review.place
        place.review_count = place.reviews.count
        place.total_rating += @review.rating
        place.avg_rating = place.total_rating / place.review_count
        place.save
        
        format.html { redirect_to(@review, :notice => 'Review was successfully created.') }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new_from_search" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to(@review, :notice => 'Review was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to(reviews_url) }
      format.xml  { head :ok }
    end
  end
end
