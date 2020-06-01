class UsersController < ApplicationController
  before_action :move_to_root,   except: [:show, :destroy]
  before_action :set_user_items, except: [:edit_done, :destroy]

  def index
    @sale_items = @items.where(auction_status: "1")
  end

  def sold_items
    @sold_items = @items.where(auction_status: "2")
  end

  def show
    @user = User.find(params[:id])
    @sale_items = @items.where(auction_status: "1")
    @item_3 = @items.first(3)
  end

  def edit_done
  end

  private
  def move_to_root
    redirect_to root_path unless user_signed_in?
  end

  def set_user_items
    @items = Item.where(user_id: current_user.id).includes(:images).order('created_at DESC')
  end
end