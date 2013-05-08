module RequestsHelper
  def show_state(label_type, aasm_state, role_type)
    label = ""
    case label_type
      when "warning"
        label << "<span class='label label-warning'>"
      when "success"
        label << "<span class='label label-success'>"
      when "important"
        label << "<span class='label label-important'>"
      when "info"
        label << "<span class='label label-info'>"
      when "inverse"
        label << "<span class='label label-inverse'>"
      else
        label << "<span class='label'>"
     end
 
    if role_type == "provider"
      label << Request.get_provider_name_string(aasm_state) + "</span>"
    else
      label << Request.get_ts_name_string(aasm_state) + "</span>"
    end
  end

  def show_id(request)
    label = "<span class='badge'>"
    label << request.id.to_s
    label << "</span>"
  end
end
