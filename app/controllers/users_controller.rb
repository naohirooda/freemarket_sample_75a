class UsersController < ApplicationController
  before_action :move_to_root, except: [:show, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def edit_done
  end

  private
  def move_to_root
    redirect_to root_path unless user_signed_in?
  end
end