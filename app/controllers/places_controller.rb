class PlacesController < ApplicationController
  # GET /places
  # GET /places.xml
  def index
    # @places = Place.all
    @places = Place.most_reviewed
    @places = Place.highest_reviewed(10)
    @reviewers = User.all(:limit => 10)
    @recent_reviews = Review.all(:limit => 10, :order => 'updated_at DESC')
    # User.all.each do |user|
    #   user
    # end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @places }
    end
  end

  # GET /places/1
  # GET /places/1.xml
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.xml
  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        format.html { redirect_to(@place, :notice => 'Place was successfully created.') }
        format.xml  { render :xml => @place, :status => :created, :location => @place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to(@place, :notice => 'Place was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to(places_url) }
      format.xml  { head :ok }
    end
  end
  
  def place_reviews
    @place = Place.find(params[:id])
    @reviews = @place.reviews
    wdpa_id = @place.wdpa_id
    data = Place.decode(@place.wdpa_id)
    @poly_string = data[0]
    @poly_centre = data[1]
    # @reviews = Review.find_all_by_place_wdpa_id(params[:id])
    # debugger    
  end
  
  def search
    # @results = ["Search results", "All in here"]
    @results = Place.search(params[:search])
    render '_search_results' 
  end
  

end
