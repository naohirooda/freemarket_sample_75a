class AddressesController < ApplicationController
  before_action :move_to_root

  def edit
    @address = Address.where(user_id: params[:id]).to_ary
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to edit_done_addresses_path
    else
      render :edit
    end
  end

  def edit_done
  end

  protected
  def address_params
    params.require(:address).permit(:post_code, :preficture, :city, :address, :building_name, :phone_number)
  end

  private
  def move_to_root
    redirect_to root_path unless user_signed_in?
  end
end
