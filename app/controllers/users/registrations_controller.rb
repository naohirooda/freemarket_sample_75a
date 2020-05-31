class Users::RegistrationsController < Devise::RegistrationsController
  before_action :move_to_root, except: [:new, :create, :create_address]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    redirect_to root_path
  end

  def edit
  end

  def update
    if current_user.update(sign_up_params)
      sign_in(current_user, :bypass => true)
      redirect_to edit_done_users_path
    else
      render :edit
    end
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
