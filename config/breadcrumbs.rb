crumb :root do
  link "トップページ", root_path
end

crumb :user_show do
  link "マイページ", user_path(current_user)
  parent :root
end

crumb :user_favorite do
  link "お気に入り商品一覧", favorites_users_path
  parent :user_show
end

crumb :user_index do
  link "出品商品一覧", users_path
  parent :user_show
end

crumb :user_sold_items do
  link "売却済商品一覧", sold_items_users_path
  parent :user_show
end

crumb :user_commented_items do
  link "コメント商品一覧", commented_items_users_path
  parent :user_show
end

crumb :card_show do
  link "お支払い方法の確認", card_path(current_user)
  parent :user_show
end

crumb :item_new do
  link "出品する"
  parent :root
end

crumb :item_show_parent do
  item = Item.find(params[:id])
  category_id = item.category_id

  if [46, 74, 134, 142, 147, 150, 158].include?(category_id)
    category_parent = Category.find(category_id).parent
    link category_parent.name
  else
    category_parent = Category.find(category_id).parent.parent
    link category_parent.name
  end
  parent :root
end

crumb :item_show_child do
  item = Item.find(params[:id])
  category_id = item.category_id

  if [46, 74, 134, 142, 147, 150, 158].include?(category_id)
    category_child = Category.find(category_id)
    link category_child.name
  else
    category_child = Category.find(category_id).parent
    link category_child.name
  end
  parent :item_show_parent
end

crumb :item_show_grandchild do
    item = Item.find(params[:id])
    category_id = item.category_id
    category_grandchild = Category.find(category_id)
    link category_grandchild.name
  parent :item_show_child
end

crumb :item_show_name do
  item = Item.find(params[:id])
  category_id = item.category_id
  link item.name, item_path(params[:id])

  if [46, 74, 134, 142, 147, 150, 158].include?(category_id)
    parent :item_show_child
  else
    parent :item_show_grandchild
  end

end

crumb :buy do
  link "購入確認"
  parent :item_show_name
end