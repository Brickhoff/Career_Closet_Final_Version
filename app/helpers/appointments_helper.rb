module AppointmentsHelper
    def action
        action_name == 'advance_search' ? :post : :get
    end
    
    def display_appointment_sorted_column_headers(search)
        string = content_tag(:th, sort_link(search, :time, "Time", method: action))
        string << content_tag(:th, sort_link(search, :user_name_cont, "Username", method: action))
        string << content_tag(:th, "Actions")
    end
    
    def display_appointment_sorted_search_results(objects)
        objects.each_with_object('') do |object, string|
            string << content_tag(:tr, display_appointment_sorted_search_results_row(object))
        end
    end
    
    def display_appointment_sorted_search_results_row(object)
        string = content_tag(:td, link_to(object.time, '/appointments/' + object.id.to_s))
        string << content_tag(:td, User.find(object.user_id).username)
        string << content_tag(:td, link_to('Edit', edit_appointment_path(object)) +'|'+ link_to('Destroy', object, method: :delete, data: { confirm: 'Are you sure?' } ))
    end
end
