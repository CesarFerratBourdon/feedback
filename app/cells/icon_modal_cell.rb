# The icon selection modal dialog
class IconModalCell < Cell::ViewModel
  include ::Cell::Haml
  def show
    render
  end

  def create_icon_row(header, icons)
    html_string = '<div class="row">'
    html_string += "<div class=\"col-xs-4 iconRowHeader\">#{header}</div>"
    icons.each do |i|
      html_string += '<div class="col-xs-4">'
      html_string += "<a href=\"#\" class=\"iconChoice\" data-icon=\"#{i}\">"
      html_string += "<i class=\"fa fa-#{i} fa-3x\"></i>"
      html_string += '</a></div>'
    end
    html_string += '</div>'
    html_string
  end
end
