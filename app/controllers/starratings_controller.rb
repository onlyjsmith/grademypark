class StarratingsController < ApplicationController
  # before_filter :authenticate_user!

  def create
    @review = Review.find_by_id(params[:review_id])
    if current_user.id == @review.id
      redirect_to review_path(@review), :alert => "You cannot rate for your own something"
    else
      @rating = Starrating.new(params[:rating])
      @rating.review_id = @review.id
      @rating.user_id = current_user.id
      if @rating.save
        respond_to do |format|
          format.html { redirect_to review_path(@review), :notice => "Your rating has been saved" }
          format.js
        end
      end
    end
  end

  def update
    # logger.info "Params #{params}"
    @review = Review.find_by_id(params[:review_id])
    # logger.info current_user.username
    if current_user.id == @review.id
      redirect_to review_path(@review), :alert => "You cannot rate for your own something"
    else
      @rating = current_user.starratings.find_by_review_id(@review.id)
      if @rating.update_attributes(params[:rating])
        respond_to do |format|
          format.html { redirect_to review_path(@review), :notice => "Your rating has been updated" }
          format.js
        end
      end
    end
  end

end