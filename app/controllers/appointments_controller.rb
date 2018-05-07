class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  # GET /appointments
  # GET /appointments.json
  def index
    if admin_logged_in?
      @search_appointment = Appointment.ransack(params[:q])
      @appointments = @search_appointment.result().paginate(page: params[:page], per_page:10)
    elsif
      @search_appointment = current_user.appointments.ransack(params[:q])
      @appointments = @search_appointment.result().paginate(page: params[:page], per_page:10)
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = @current_user
    @slots = Appointment.where(:time => @appointment.time, :slot => @appointment.slot).count
    respond_to do |format|
      if ((@current_user.available) && (@slots<2))
        if @appointment.save
          UserMailer.make_appointment(@current_user, @appointment).deliver
          User.find(@current_user.id).update_attribute(:available, false)
          flash[:success] = 'Appointment was successfully created.'
          format.html { redirect_to @appointment}
          format.json { render :show, status: :created, location: @appointment }
        else
          format.html { render :new }
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
        end
      elsif @slots >=2
          redirect_to new_appointment_path , flash[:danger] = "This time slot is full."
      else
          flash[:danger] ='You can only has one appointment.'
          format.html { render :new}
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    @appointment.user = @current_user
    respond_to do |format|
      if @appointment.update(appointment_params)
        UserMailer.edit_appointment(@current_user, @appointment).deliver
        flash[:success] ='Appointment was successfully updated.'
        format.html { redirect_to @appointment}
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    User.find(@appointment.user_id).update_attribute(:available, true)
    @appointment.user = @current_user
    if current_user
      UserMailer.cancel_appointment(@current_user).deliver
    end
    @appointment.destroy
    respond_to do |format| 
      flash[:success] = 'Appointment was successfully destroyed.'
      format.html { redirect_to appointments_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      if current_user || current_admin
          @appointment = Appointment.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
          params.require(:appointment).permit(:user_id, :time, :slot)
    end
    
    def require_same_user
      if !current_user  && !current_admin
        flash[:danger] = "You only can edit your own information."
        redirect_to root_path
      end
    end

    def require_user
      if !(user_logged_in? || admin_logged_in?)
        flash[:danger] = "Please log in to our perform."
        redirect_to root_path
      end
    end
end
