class ItemsController < ApplicationController
  before_action :category_parent_array, only: [:new, :create]

  def index
  end

  def new
    @item = Item.new
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
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  private
  def item_params
    params.require(:item).permit(:item_name,:category_id)
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil).each do |parent|
    end
  end
end
