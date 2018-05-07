module HistoriesHelper
    
    def action
        action_name == 'advance_search' ? :post : :get
    end
    
    def display_history_sorted_column_headers(search)
           string = content_tag(:th, sort_link(search, :suit_appid_cont , "App. ID", method: action))
           string << content_tag(:th, sort_link(search, :user_uin_cont , "Customer UIN", method: action))
           string << content_tag(:th, sort_link(search, :checkOutTime , "Checkout time", method: action))
           string << content_tag(:th, sort_link(search, :returnTime , "Return Time", method: action))
           string << content_tag(:th, sort_link(search, :checkOutTime , "Period", method: action))
           string << content_tag(:th, "Actions")
           
    end
    
    def display_history_sorted_search_results(objects)
        objects.each_with_object('') do |object, string|
            string << content_tag(:tr, display_history_sorted_search_results_row(object))
        end
    end
    
    def display_history_sorted_search_results_row(object)
            string = content_tag(:td, link_to(Suit.find(object.suit_id).appid, '/histories/' + object.id.to_s))
            string << content_tag(:td, link_to(User.find(object.user_id).uin, '/histories/' + object.id.to_s))
            string << content_tag(:td, object.checkOutTime.strftime("%Y/%m/%d"))
            if !object.returnTime.nil?
                string << content_tag(:td, object.returnTime.strftime("%Y/%m/%d"))
                string << content_tag(:td, (object.returnTime.day - object.checkOutTime.day).to_i)
            else
                string << content_tag(:td, "")
                string << content_tag(:td, "")
            end
            string << content_tag(:td, link_to('Edit', edit_history_path(object)) +'|'+link_to('Delete', object, method: :delete, data: { confirm: 'Are you sure?' } ))
    end
end
