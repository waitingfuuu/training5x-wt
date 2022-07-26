# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.password == params[:session][:password]
      log_in user
      redirect_to root_path
    else
      flash.now[:login_error] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:session).permit(:name, :password)
  end
end