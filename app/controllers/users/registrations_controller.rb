class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:public_signup, :create]
  skip_before_action :authenticate_user!
  skip_before_action :require_admin!

  def public_signup
    @user = User.new
    render :public_signup
  end
end
