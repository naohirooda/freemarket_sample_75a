class ItemsController < ApplicationController
before_action :category_parent_array, only: [:new, :create, :edit, :update]
before_action :set_item, only: [:show, :edit, :update, :destroy]
before_action :show_all_instance, only: [:show, :edit, :update, :destroy]
before_action :check_item_details, only: [:post_done, :update_done]
before_action :category_map, only: [:edit, :update]
# before_action :images_new, only: [:new, :create, :edit, :update]

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

  def show
  end

  def edit
  end


  def update
    # 登録済画像のidの配列を生成
    ids = @images = Image.where(item_id: params[:id]).map{|image| image.id }
    # 登録済画像のうち、編集後もまだ残っている画像のidの配列を生成(文字列から数値に変換)
    exit_ids = []
    item_params[:images_attributes].each do |a,b|
      exit_ids << item_params[:images_attributes].dig(:"#{a}",:id).to_i
    end
    exit_ids_uniq = exit_ids.uniq
    # 登録済画像が残っていない場合(配列に０が格納されている)、配列を空にする
    # exist_ids_uniq.clear if exist_ids[0] == 0

    # DB内の画像で編集後に残っていないidの画像を削除
    delete__db = ids - exit_ids_uniq
    binding.pry
    Image.where(id:delete__db).destroy_all
    if @item.update(item_params)
      redirect_to  update_done_items_path
    else
      flash.now[:alert] = '更新できませんでした'
      render :edit
    end
  end

  def update_done
  end
  
  def destroy
    if @item.destroy
      redirect_to  delete_done_items_path
    else
      flash.now[:alert] = '削除できませんでした'
      render :show
    end
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

  def check_item_details
    @item = Item.where(user_id: current_user.id).last
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

  def category_map
    grandchild = @item.category
    child = grandchild.parent
    if @category_id == 46 or @category_id == 74 or @category_id == 134 or @category_id == 142 or @category_id == 147 or @category_id == 150 or @category_id == 158
      @category_children_array = Category.children(child).each do |child|
      end
      @child_array = []
      @child_array << child.name
      @child_array << child.id

      @category_grandchildren_array = Category.grandchildren(grandchild).each do |child|
      end
      @grandchild_array = []
      @grandchild_array << grandchild.name
      @grandchild_array << grandchild.id
    else
      @parent_array = []
      @parent_array << @item.category.parent.parent.name
      @parent_array << @item.category.parent.parent.id

      @category_children_array = Category.children(child).each do |child|
      end
      @child_array = []
      @child_array << child.name
      @child_array << child.id

      @category_grandchildren_array = Category.grandchildren(grandchild).each do |child|
      end
      @grandchild_array = []
      @grandchild_array << grandchild.name
      @grandchild_array << grandchild.id
    end
  end
end
