module AdminsHelper
    
    def action
        action_name == 'advance_search' ? :post : :get
    end
    
    def display_admin_sorted_column_headers(search)
           string = content_tag(:th, sort_link(search, :name , "Name", method: action))
           string << content_tag(:th, sort_link(search, :email, "Email", method: action))
           string << content_tag(:th, sort_link(search, :code, "Code", method: action))
           string << content_tag(:th, "Actions")
    end
    
    def display_admin_sorted_search_results(objects)
        objects.each_with_object('') do |object, string|
            string << content_tag(:tr, display_admin_sorted_search_results_row(object))
        end
    end
    
    def display_admin_sorted_search_results_row(object)
        string = content_tag(:td, object.name)
        string << content_tag(:td, object.email)
        string << content_tag(:td, object.code)
        string << content_tag(:td, link_to('Edit', edit_admin_path(object)) +'|'+link_to('Delete', object, method: :delete, data: { confirm: 'Are you sure?' } ))
    end
  
end
