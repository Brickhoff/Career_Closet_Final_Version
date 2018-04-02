class RentersController < ApplicationController
  def index
    @q_renters = Renter.ransack(params[:q])
    @renters = @q_renters.result().where(:user_id => session[:user_id]).paginate(page: params[:page]) || []
  end

  def show
    @renters = Renter.find(params[:id])
  end

  def new
    @renters = Renter.new
  end

  def edite
    @renters = Renter.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end
end
