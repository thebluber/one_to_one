module ApplicationHelper
  def flash_message
    flash.map do |key, msg|
      if key == "alert" || key == "error"
        content_tag :div, msg, :class => 'alert alert-danger'
      else
        content_tag :div, msg, :class => 'alert'
      end
    end.join.html_safe
  end
end
