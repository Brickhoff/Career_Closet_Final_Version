module RentersHelper
        
    def action
        action_name == 'advance_search' ? :post : :get
    end
    
    def display_renter_sorted_column_headers(search)
           string = content_tag(:th, sort_link(search, :checkOutTime , "Check Out Time", method: action))
           string << content_tag(:th, sort_link(search, :expectReturnTime , "Expected Return Time", method: action))
           string << content_tag(:th, sort_link(search, :expectReturnTime , "Due", method: action))
           string << content_tag(:th, sort_link(search, :user_uin_cont , "Customer UIN", method: action))
           string << content_tag(:th, sort_link(search, :suit_appid_cont, "Suit App. ID", method: action))
           string << content_tag(:th, "Actions")
           
    end
    
    def display_renter_sorted_search_results(objects)
        objects.each_with_object('') do |object, string|
            string << content_tag(:tr, display_renter_sorted_search_results_row(object))
        end
    end
    
    def display_renter_sorted_search_results_row(object)
            string = content_tag(:td, object.checkOutTime.strftime("%Y/%m/%d"))
            string << content_tag(:td, object.expectReturnTime.strftime("%Y/%m/%d"))
            string << content_tag(:td, (object.expectReturnTime.to_date- Time.now.to_date).to_i)
            string << content_tag(:td, link_to(User.find(object.user_id).uin, '/renters/' + object.id.to_s))
            string << content_tag(:td, link_to(Suit.find(object.suit_id).appid, '/renters/' + object.id.to_s))
            string << content_tag(:td, link_to('Edit', edit_renter_path(object)) +'|'+link_to('Return', object, method: :delete, data: { confirm: 'Are you sure?' } ))
    end
end
