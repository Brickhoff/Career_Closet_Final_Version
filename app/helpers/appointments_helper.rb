module AppointmentsHelper
    def action
        action_name == 'advance_search' ? :post : :get
    end
    
    def display_appointment_sorted_column_headers(search)
        string = content_tag(:th, sort_link(search, :time, "Date", method: action))
        string << content_tag(:th, sort_link(search, :slot, "Time", method: action))
        string << content_tag(:th, sort_link(search, :user_first_cont, "Name", method: action))
        string << content_tag(:th, sort_link(search, :user_uin_cont, "UIN:", method: action))
        string << content_tag(:th, "Actions")
    end
    
    def display_appointment_sorted_search_results(objects)
        objects.each_with_object('') do |object, string|
            string << content_tag(:tr, display_appointment_sorted_search_results_row(object))
        end
    end
    
    def display_appointment_sorted_search_results_row(object)
        string = content_tag(:td, link_to(object.time.strftime("%Y/%m/%d"), '/appointments/' + object.id.to_s))
        string << content_tag(:td, object.slot)
        string << content_tag(:td, User.find(object.user_id).full_name)
        string << content_tag(:td, User.find(object.user_id).uin)
        string << content_tag(:td, link_to('Edit', edit_appointment_path(object)) +'|'+ link_to('Cancel', object, method: :delete, data: { confirm: 'Are you sure?' } ))
    end
end
