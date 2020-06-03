class TopController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC').first(3)
    @rand_items = Item.includes(:images).order("RAND()").limit(3)
  end
end