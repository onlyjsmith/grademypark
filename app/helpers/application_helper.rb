module ApplicationHelper    

  def render_stars(rating)
    content_tag(:div, star_images(rating).html_safe)
  end

  def star_images(rating)
    (0...rating).map do |position|
      image_tag ("icons/star_fill_sm.png"), {:class => "stars"}
    end.join
  end 

end
