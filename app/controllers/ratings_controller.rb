class RatingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @review = Review.find_by_id(params[:review_id])
    if current_user.id == @review.id
      redirect_to review_path(@review), :alert => "You cannot rate for your own photo"
    else
      @rating = Rating.new(params[:rating])
      @rating.photo_id = @review.id
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
    @review = Review.find_by_id(params[:review_id])
    if current_user.id == @photo.id
      redirect_to photo_path(@photo), :alert => "You cannot rate for your own photo"
    else
      @rating = current_user.ratings.find_by_photo_id(@photo.id)
      if @rating.update_attributes(params[:rating])
        respond_to do |format|
          format.html { redirect_to photo_path(@photo), :notice => "Your rating has been updated" }
          format.js
        end
      end
    end
  end

end