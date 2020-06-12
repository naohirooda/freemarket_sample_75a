class UsersController < ApplicationController
  before_action :move_to_root,     except: [:show, :destroy]
  before_action :set_user_items,   except: [:edit_done, :destroy]
  before_action :set_sale_items,   only:   [:index, :show]

  def index
  end

  def sold_items
    @sold_items = @items.where(auction_status: "2").order('created_at DESC')
  end

  def commented_items
    @commented_items = Item.where(user_id: current_user.id).joins(:comments).uniq
  end

  def favorites
    @favorites = Favorite.where(user_id: current_user)
  end

  def show
    @user = User.find(params[:id])
    @item_3 = @items.order('updated_at DESC').first(3)
    @to_comments = Comment.where(user_id: current_user.id)
    @be_commented = Comment.where.not(user_id: current_user.id).where(item_id: @items.ids)
  end

  def edit_done
  end

  private
  def move_to_root
    redirect_to root_path unless user_signed_in?
  end

  def set_user_items
    @items = Item.where(user_id: current_user.id).includes(:images).includes(:comments)
  end

  def set_sale_items
    @sale_items = Item.where(user_id: current_user.id).where(auction_status: "1").includes(:images).includes(:comments)
  end
end