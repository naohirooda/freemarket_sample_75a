class ItemsController < ApplicationController
before_action :category_parent_array, only: [:new, :create]
before_action :set_item, only: [:show, :destroy]
before_action :show_all_instance, only: [:show, :destroy]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to  post_done_items_path
    else
      @item.images.new
      render :new
    end
  end

  def  post_done
    @item = Item.where(user_id: current_user.id).last
  end

  def edit
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def update
  end
  
  def destroy
    if @item.destroy
      redirect_to  delete_done_items_path
    else
      flash.now[:alert] = '削除できませんでした'
      render :show
    end
  end

  def search
    @search_items = Item.search(params[:keyword])
    @keyword = params[:keyword]
  end

  private
  def item_params
    params.require(:item).permit(:name, :item_explanation, :category_id, :item_status, :auction_status, :delivery_fee, :shipping_origin, :exhibition_price,:brand_name, :days_until_shipping, images_attributes:  [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end
 
  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil).each do |parent|
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def show_all_instance
    @user = User.find(@item.user_id)
    @images = Image.where(item_id: params[:id])
    @images_first = Image.where(item_id: params[:id]).first
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end
end
