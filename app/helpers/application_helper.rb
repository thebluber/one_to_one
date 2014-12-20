module ApplicationHelper
  def flash_message flash
    flash.map do |key, msg|
      if key == "alert" || key == "error"
        content_tag :div, msg, :class => 'alert alert-danger'
      else
        content_tag :div, msg, :class => 'alert alert-info'
      end
    end.join.html_safe
  end

  def icon name, size
    "<i class='fa fa-#{name} fa-#{size}'></i>".html_safe
  end

  def stringify_semester semester
    if semester.start.month <= 6
      "SS#{semester.start.year}"
    else
      "WS#{semester.start.year}/#{semester.start.year + 1}"
    end
  end
end
