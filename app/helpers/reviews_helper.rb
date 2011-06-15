module ReviewsHelper
  def short_title(review)
    cutoff = 50
    if review.review_text.length >= cutoff
      review.review_text[0..cutoff]+"..." 
    else 
      review.review_text
    end
    
  end
  
  def rating_ballot
    if @rating = current_user.ratings.find_by_review_id(params[:id])
      @rating
    else
      current_user.ratings.new
    end    
  end
  
  def current_user_rating
    if @rating = current_user.ratings.find_by_review_id(params[:id])
      @rating.value
    else
      "N/A"
    end
  end
end
