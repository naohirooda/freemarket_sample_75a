class FavoritesController < ApplicationController
  def create
    if user_signed_in?
      Favorite.create(user_id: current_user.id, item_id: params[:item_id])
      @favorites = Favorite.where(item_id: params[:item_id])
      @item = Item.find(params[:item_id])
      @user_favorite = @favorites.where(user_id: current_user)
      render 'create.js.haml'
    else
      redirect_to item_path(params[:item_id]), alert: :'お気に入り登録はログインして使用して下さい'
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, item_id: params[:item_id])
    if user_signed_in? && current_user.id == @favorite.user_id
      @favorite.destroy
      @favorites = Favorite.where(item_id: params[:item_id])
      @item = Item.find(params[:item_id])
      @user_favorite = @favorites.where(user_id: current_user)
      render 'destroy.js.haml'
    else
      redirect_to item_path(params[:item_id]), alert: :'お気に入り削除はログインして使用して下さい'
    end
  end
end