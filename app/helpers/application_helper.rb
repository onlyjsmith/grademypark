module ApplicationHelper                                       


  def proportion_reviewed
    ("%0.4f" % (Place.count / 170000.0)).to_f * 100
  end

  def render_stars(rating)
    content_tag(:div, star_images(rating).html_safe)
  end

  def star_images(rating)
    (0...rating).map do |position|
      image_tag ("icons/star_fill_sm.png"), {:class => "stars"}
    end.join
  end 

  def rating_ballot
      if @rating = current_user.ratings.find_by_place_id(params[:id])
          @rating
      else
          current_user.ratings.new
      end
  end
  
end
