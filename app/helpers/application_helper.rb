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
end
