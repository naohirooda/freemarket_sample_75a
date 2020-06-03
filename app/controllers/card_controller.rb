class CardController < ApplicationController
  before_action :move_to_root
  before_action :set_card, only: [:new, :show, :destroy, :buy, :pay]
  before_action :set_item, only: [:buy, :pay]
  require "payjp"

  def new
    redirect_to card_path(current_user.id) if @card.present?
  end

  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to registration_done_card_index_path
      else
        redirect_to new_card_path
      end
    end
  end

  def registration_done
  end

  def show
    if @card.blank?
      redirect_to new_card_path 
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_info = customer.cards.retrieve(@card.card_id)
      case @card_info.brand
        when "Visa"
          @card_src = "visa.gif"
        when "JCB"
          @card_src = "jcb.gif"
        when "MasterCard"
          @card_src = "mc.png"
        when "American Express"
          @card_src = "amex.gif"
        when "Diners Club"
          @card_src = "diners.gif"
        when "Discover"
          @card_src = "discover.gif"
      end
    end
  end

  def destroy
    if @card.blank?
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      redirect_to delete_done_card_index_path
  end

  def delete_done
  end

  def buy
    if user_signed_in?
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
      if @card.blank?
        @card_info = ""
      else
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @card_info = customer.cards.retrieve(@card.card_id)
        case @card_info.brand
          when "Visa"
            @card_src = "visa.gif"
          when "JCB"
            @card_src = "jcb.gif"
          when "MasterCard"
            @card_src = "mc.png"
          when "American Express"
            @card_src = "amex.gif"
          when "Diners Club"
            @card_src = "diners.gif"
          when "Discover"
            @card_src = "discover.gif"
        end
      end
    else
      redirect_to root_path
    end
  end

  def pay
    if @item == "売り切れ"
      redirect_to buy_card_path(@item.id)
    else
      if current_user.card.present?
        Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
        charge = Payjp::Charge.create(
          amount: @item.exhibition_price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        @item.update!(auction_status: 2)
      else
        Payjp::Charge.create(
          amount: @item.exhibition_price,
          card: params['payjp-token'],
          currency: 'jpy'
          )
        @item.update!(auction_status: 2)
      end
    end
  end

  private
  def move_to_root
    redirect_to root_path unless user_signed_in?
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
