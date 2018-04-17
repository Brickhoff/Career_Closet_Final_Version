module UsersHelper
    def user_fields
        [:first_name, :last_name, :uin, :phone, :email]
    end
    
    def action
        action_name == 'advance_search' ? :post : :get
    end
    
    def display_user_sorted_column_headers(search)
           string = content_tag(:th, sort_link(search, :first_name , "First Name", method: action))
           string << content_tag(:th, sort_link(search, :last_name , "Last Name", method: action))
           string << content_tag(:th, sort_link(search, :uin , "UIN", method: action))
           string << content_tag(:th, sort_link(search, :phone , "Phone", method: action))
           string << content_tag(:th, sort_link(search, :email , "E-mail", method: action))
           string << content_tag(:th, "Actions")
    end
    
    def display_user_sorted_search_results(objects)
        objects.each_with_object('') do |object, string|
            string << content_tag(:tr, display_user_sorted_search_results_row(object))
        end
    end
    
    def display_user_sorted_search_results_row(object)
        string = content_tag(:td, object.first_name)
        string << content_tag(:td, object.last_name)
        string << content_tag(:td, object.uin)
        string << content_tag(:td, object.phone)
        string << content_tag(:td, object.email)
        string << content_tag(:td, link_to('Edit', edit_user_path(object)) +'|'+link_to('Delete', object, method: :delete, data: { confirm: 'Are you sure?' } ))
    end
end
