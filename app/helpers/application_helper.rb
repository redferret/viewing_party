module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice'
      "class='alert alert-info text-center'".html_safe
    when 'success'
      "class='alert alert-success text-center'".html_safe
    when 'alert'
      "class='alert alert-danger text-center'".html_safe
    end
  end
end
