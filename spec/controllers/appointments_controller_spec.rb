require 'rails_helper'

describe AppointmentsController do
#Tesing GET methods    
    describe "GET #index" do
        before :each do
            admin_log_in
        end
        it "populates an array of appointments" do
            appointment = FactoryGirl.create(:appointment)
            get :index
            assigns(:appointments).should eq([appointment])
            visit suits_path
            current_path.should eq(suits_path)
        end
        it "renders the :index template" do
            get :index
            expect(response).to render_template :index
        end
    end
    describe "GET #show" do
        before :each do
            admin_log_in
        end
        it "assigns the requested appointment to @appointment" do
            appointment = FactoryGirl.create(:appointment)
            get :show, params: { id: appointment.id}
            assigns(:appointment).should eq(appointment)
        end
        
        it "renders the :show template" do
            appointment = FactoryGirl.create(:appointment)
            get :show, params: { id: appointment.id}
            expect(response).to render_template :show
        end
    end
    describe "GET #new" do
        before :each do
            user_log_in
        end
        it "assigns a new appointment to @appointment" do
            get :new
            assigns(:appointment).should be_a_new(Appointment)
        end
        
        it "renders the :new template" do
            get :new
            expect(response).to render_template :new
        end
    end
    describe "GET#edit" do
        before :each do
            user_log_in
        end
        it "assigns the requested appointment to @appointment" do
            appointment = FactoryGirl.create(:appointment)
            get :show, params: { id: appointment.id}
            assigns(:appointment).should eq(appointment)
        end
        it "renders the :edit template" do
            appointment = FactoryGirl.create(:appointment)
            get :edit, params: { id: appointment.id}
            expect(response).to render_template :edit
        end
    end
#Testing POST methods
    describe "POST#create" do
        before :each do
            user_log_in
        end
        context "with valid attributes" do
            it "creates a new appointment" do
                expect{
                    post :create, params: {appointment: FactoryGirl.attributes_for(:appointment)}
                }.to change(Appointment,:count).by(1)
            end
            it "redirects to the new appointment" do
                post :create, params: {appointment: FactoryGirl.attributes_for(:appointment)}
                response.should redirect_to Appointment.last
            end
        end
        context "with invalid attributes" do
            it "redirect_to root page" do
                post :create, params: {appointment: FactoryGirl.attributes_for(:invalid_appointment)}
                response.should render_template :new
            end
        end
    end
#Testing PUT methods
    describe 'PUT update' do
        before :each do
            user_log_in
            @appointment = FactoryGirl.create(:appointment, time: DateTime.new(2018,5,6,7,8))
        end
        
        context "valid attributes" do
            it "located the requested @appointment" do
                put :update, params: { id: @appointment.id, appointment: FactoryGirl.attributes_for(:appointment)}
                assigns(:appointment).should eq(@appointment)
            end
            
            it "changes @appointment's attributes" do
                put :update, params: { id: @appointment.id, appointment: FactoryGirl.attributes_for(:appointment, time: DateTime.new(2018,5,6,8,9))}
                @appointment.reload
                @appointment.time.should eq(DateTime.new(2018,5,6,8,9))
            end
            
            it "redirects to the updated appointment" do
                put :update, params: { id: @appointment.id, appointment: FactoryGirl.attributes_for(:appointment)}
                    response.should redirect_to @appointment
            end
        end
        
        context "invalid attributes" do
            it "locates the requested @appointment" do
                put :update, params: { id: @appointment.id, appointment: FactoryGirl.attributes_for(:invalid_appointment)}
                assigns(:appointment).should eq(@appointment)
            end
            
            it "does not change @appointment's attributes" do
                put :update, params: { id: @appointment.id, appointment: FactoryGirl.attributes_for(:appointment, time: DateTime.new(2018,5,6,8,9))}
                @appointment.reload
                @appointment.time.should eq(DateTime.new(2018,5,6,8,9))
            end
            
            it "re-renders the edit method" do
                put :update, params: { id: @appointment.id, appointment: FactoryGirl.attributes_for(:invalid_appointment)}
                    response.should render_template :edit
            end
        end
    end
#Testing DELETE methods
    describe 'DELETE destroy' do
        before :each do
            user_log_in
            @appointment = FactoryGirl.create(:appointment)
        end
        
        it "deletes the contact" do
            expect{
                delete :destroy, params: {id: @appointment}
            }.to change(Appointment,:count).by(-1)
        end
        
        it "redirects to contacts#index" do
            delete :destroy, params: {id: @appointment}
            response.should redirect_to appointments_url
        end
    end
end