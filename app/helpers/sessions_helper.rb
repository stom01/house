module SessionsHelper
  def signed_in?
    check_tokens? && check_time?
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

  private

  def check_tokens?
    Session.is_valid?(session[:remember_id], session[:remember_token])
  end

  def check_time?
    if Time.parse(session[:expires_at]) < Time.current
      clear_session
      false
    else
      true
    end
  end

  def clear_session
    Session.clear_session(session[:remember_id])
    session[:remember_id] = ""
    session[:remember_token] = ""
    session[:expires_at] = ""
    flash[:warning] = "Session Expired"
  end
end
