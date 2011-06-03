class RichcontentsController < ApplicationController
  # GET /richcontents
  # GET /richcontents.xml
  def index
    @richcontents = Richcontent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @richcontents }
    end
  end

  # GET /richcontents/1
  # GET /richcontents/1.xml
  def show
    @richcontent = Richcontent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @richcontent }
    end
  end

  # GET /richcontents/new
  # GET /richcontents/new.xml
  def new
    @richcontent = Richcontent.new
    @richcontent.content_type = 2
    @richcontent.review_id = Review.find(params[:id]).id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @richcontent }
    end
    
  end

  # GET /richcontents/1/edit
  def edit
    @richcontent = Richcontent.find(params[:id])
  end

  # POST /richcontents
  # POST /richcontents.xml
  def create
    @richcontent = Richcontent.new(params[:richcontent])

    respond_to do |format|
      if @richcontent.save
        format.html { redirect_to("/places/#{Review.find(@richcontent.review_id).place.id}/place_reviews", :notice => 'Richcontent was successfully created.') }
        format.xml  { render :xml => @richcontent, :status => :created, :location => @richcontent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @richcontent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /richcontents/1
  # PUT /richcontents/1.xml
  def update
    @richcontent = Richcontent.find(params[:id])

    respond_to do |format|
      if @richcontent.update_attributes(params[:richcontent])
        format.html { redirect_to(@richcontent, :notice => 'Richcontent was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @richcontent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /richcontents/1
  # DELETE /richcontents/1.xml
  def destroy
    @richcontent = Richcontent.find(params[:id])
    @richcontent.destroy

    respond_to do |format|
      format.html { redirect_to(richcontents_url) }
      format.xml  { head :ok }
    end
  end
end
