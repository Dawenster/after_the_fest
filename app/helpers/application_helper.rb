module ApplicationHelper
  def set_video_dimentions(str)
    str.gsub!("780px", "100%")
    str.gsub!("440px", "100%")
    str.gsub!("content=\"780\"", "content=\"100%\"")
    str.gsub!("content=\"440\"", "content=\"100%\"")
    return str
  end

  def page_is_festival_specific?
    (params[:controller] == "festivals" && params[:action] == "show") || 
    (params[:controller] == "genres" && params[:action] == "show") || 
    (params[:controller] == "films" && params[:action] == "show") || 
    (params[:controller] == "awards" && params[:action] == "index")
  end

  def generate_meta_tags(title, description, image)
    meta :title => title, :description => description
    meta [:property => "og:image", :content => image] unless image.blank?
    meta [:property => "og:title", :content => title]
    meta [:property => "og:url", :content => request.original_url]
    meta [:property => "og:description", :content => description]
    meta [:property => "og:type", :content => "website"]
  end
end
