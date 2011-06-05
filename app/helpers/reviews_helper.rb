module ReviewsHelper
  def short_title(review)
    cutoff = 50
    if review.review_text.length >= cutoff
      review.review_text[0..cutoff]+"..." 
    else 
      review.review_text
    end
    
  end
end
