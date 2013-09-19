#encoding: utf-8
class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
  end

  def index
    authorize! :index, UsersController
    @users = User.paginate(page: params[:page], per_page: 50)
  end

  def destroy
    authorize! :destroy, UsersController
    @user = User.find_by_id(params[:id])
    if @user && @user.destroy
      flash[:success] = "Пользователь и связанная с ним информация была удалена!"
    else
      flash[:error] = 'Ошибка удаления.'
    end
    redirect_to users_path
  end

  def edit
    authorize! :edit, UsersController
    @user = User.find_by_id(params[:id])
  end

  def update
    authorize! :update, UsersController
    @user = User.find_by_id(params[:id])
    role = params[:user] ? params[:user][:role].to_s.strip.downcase : ''
    if @user && %w(user admin).include?(role)
      @user.role = role
      if @user.save
        flash[:success] = 'Пользователь успешно отредактирован!'
        redirect_to edit_user_path(@user)
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end
end