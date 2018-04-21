module SpecTestHelper
    def admin_log_in
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
    end

end