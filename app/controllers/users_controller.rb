class UsersController < ApplicationController
  before_action :move_to_root,     except: [:show, :destroy]
  before_action :set_user_items,   except: [:edit_done, :destroy]
  before_action :set_be_commented, only: [:be_commented, :show]
  before_action :set_to_comments,  only: [:to_comments, :show]

  def index
    @sale_items = @items.where(auction_status: "1")
  end

  def sold_items
    @sold_items = @items.where(auction_status: "2")
  end

  def be_commented
  end

  def to_comments
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
    @items = Item.where(user_id: current_user.id).includes(:images).includes(:comments).order('created_at DESC')
  end

  def set_be_commented
    items = Item.where(user_id: current_user.id).includes(:images).includes(:comments)
    comments = Comment.where.not(user_id: current_user.id)
    @be_commented = comments.where(item_id: items.ids)
  end

  def set_to_comments
    @to_comments = Comment.where(user_id: current_user.id)
  end
end