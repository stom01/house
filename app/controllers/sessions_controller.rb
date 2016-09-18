class SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]
  before_action :already_signed_in, only: [:new, :create]

  def create
    if password == Rails.configuration.password
      login
      redirect_to root_path
    else
      flash[:danger] = "Wrong Password"
      redirect_to root_path
    end
  end

  def destroy
    Session.where(id: session[:remember_id]).destroy_all
    session[:remember_token] = ""
    session[:remember_id] = ""
    flash[:success] = "Signed out!"
    redirect_to root_path
  end

  private

  def login
    session[:remember_token] = BCrypt::Password.create("")
    session[:remember_id] = Session.create(password: session[:remember_token]).id
    session[:expires_at] = Time.current.advance(days: 7)
    flash[:success] = "Signed in!"
  end

  def password
    BCrypt::Engine.hash_secret(params['password'], Rails.configuration.salt)
  end
end
