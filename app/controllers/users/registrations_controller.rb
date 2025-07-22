def public_signup
  @user = User.new
  render :public_signup
end
