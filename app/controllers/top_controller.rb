class TopController < ApplicationController
  def index
    # @items = Item.includes(:images).order('created_at DESC').first(3)
  end
end