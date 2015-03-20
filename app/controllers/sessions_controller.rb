class SessionsController < ApplicationController
  def create
    @authentication = Authentication.find_or_create_from_auth_hash(auth_hash)
    sign_in @authentication.user

    redirect_to '/'
  end

  def index

  end

  def set_code
    code = params[:echo_code][:code]
    echos = EchoUser.where(authentication_id: nil).where(registration_code: code)
    if echos.count == 1
      echo = echos.first
      echo.update(authentication_id: current_user.authentication.id)
      redirect_to root_path, notice: "All set!"
    else
      redirect_to root_path, notice: "Could not use that code"
    end
  end


  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end