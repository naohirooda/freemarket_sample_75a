class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :exhibition_price, :auction_status, images_attributes: [:image]).merge(user_id: current_user.id)
  end
end
