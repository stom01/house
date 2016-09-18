class SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]
  before_action :already_signed_in, only: [:new, :create]

  def create
    if password == Rails.configuration.password
      session[:remember_token] = BCrypt::Password.create("")
      session[:remember_id] = Session.create(password: session[:remember_token]).id
      flash[:success] = "Signed in!"
      redirect_to root_path
    else
      flash[:danger] = "Wrong Password"
      redirect_to root_path
    end
  end

  def destroy
    Session.where(id: session[:remember_id]).destroy_all
    session[:remember_token] = nil
    session[:remember_id] = nil
    flash[:success] = "Signed out!"
    redirect_to root_path
  end

  private

  def password
    BCrypt::Engine.hash_secret(params['password'], Rails.configuration.salt)
  end
end
