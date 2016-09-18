module SessionsHelper
  def signed_in?
    Session.is_valid?(session[:remember_id], session[:remember_token])
  end

  def authenticate
    unless signed_in?
      flash[:danger] = "For admin access only"
      redirect_to root_path
    end
  end

  def already_signed_in
    if signed_in?
      flash[:danger] = "You are already signed in"
      redirect_to root_path
    end
  end
end
