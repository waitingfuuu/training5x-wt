# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[tasks edit update destroy]

    def index
      @current_user ||= User.find(session[:user_id])
      unless @current_user.admin == 'admin'
        flash[:notice] = t('flash.user_not_admin')

        redirect_to root_path
        return
      end

      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        flash[:notice] = t('flash.user_successfully_created')

        redirect_to admin_users_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:notice] = t('flash.user_successfully_edited')

        redirect_to admin_users_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @user == User.find(session[:user_id])
        flash[:notice] = t('flash.can_not_delete_current_user')
        redirect_to admin_users_path
        return
      end

      @user.tasks.destroy_all
      User.destroy(params[:id])

      flash[:notice] = t('flash.user_successfully_deleted')
      redirect_to admin_users_path
    end

    def tasks; end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :admin, :password)
    end
  end
end
