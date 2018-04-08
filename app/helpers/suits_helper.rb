module SuitsHelper
    
    def action
        action_name == 'advance_search' ? :post : :get
    end
    
    def display_suit_sorted_column_headers(search)
        string = content_tag(:th, sort_link(search, :appid, "Suit ID", method: action))
        string << content_tag(:th, sort_link(search, :gender, "Gender", method: action))
        string << content_tag(:th, sort_link(search, :size, "Size", method: action))
        string << content_tag(:th, sort_link(search, :user_uin_cont, "Customer UIN", method: action))
        string << content_tag(:th, sort_link(search, :status, "Status", method: action))
        string << content_tag(:th, "Actions")
    end
    
    def display_suit_sorted_search_results(objects)
        objects.each_with_object('') do |object, string|
            string << content_tag(:tr, display_suit_sorted_search_results_row(object))
        end
    end
    
    def display_suit_sorted_search_results_row(object)
        @find = Renter.where(suit_id: object.id)
        string = content_tag(:td, link_to(object.appid, '/suits/' + object.id.to_s))
        string << content_tag(:td, object.gender)
        string << content_tag(:td, object.size)
        if @find.blank?
            string << content_tag(:td, "" )
        else
            string << content_tag(:td, User.find((Renter.find(object.id)).user_id).uin)
        end
        string << content_tag(:td, object.status)
        string << content_tag(:td, link_to('Edit', edit_suit_path(object)) +'|'+link_to('Delete', object, method: :delete, data: { confirm: 'Are you sure?' } ))
    end
    
end
