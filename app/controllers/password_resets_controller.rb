#encoding: utf-8
class PasswordResetsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      redirect_to(root_path, :notice => 'Instructions have been sent to your email.')
    else
      flash.now[:error] = "Ungültige Email Adresse!"
      render :new
    end
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated("Reset Password Token nicht gültig!") if !@user
  end

  def update
    @token = params[:id] # needed to render the form again in case of error
    @user = User.load_from_reset_password_token(@token)
    unless @user
      not_authenticated("Reset Password Token nicht gültig!")
    else
      if @user.change_password!(params[:user][:password])
        redirect_to(root_path, :notice => 'Password was successfully updated.')
      else
        flash.now[:error] = @user.errors.full_messages.join(" ")
        render :edit
      end
    end
  end

end
