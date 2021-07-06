module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice'
      "class='alert alert-info'".html_safe
    when 'success'
      "class='alert alert-success'".html_safe
    when 'alert'
      "class='alert alert-danger'".html_safe
    end
  end
end
