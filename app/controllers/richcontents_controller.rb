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
    @richcontent.review_id = Review.find(params[:id]).id
    # logger.info @richcontent.inspect
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

    @richcontent.content_type = 2
    logger.info params

    if @richcontent.content_url.scan(/https?:\/\//).empty?
      @richcontent.prefix = "http://"
    else
      split = @richcontent.content_url.split("://")
      @richcontent.prefix = split[0] + "://"
      @richcontent.content_url = split[1]
    end

    respond_to do |format|
      if @richcontent.save
        format.html { redirect_to(review_path(@richcontent.review_id), :notice => 'Richcontent was successfully created.') }
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
