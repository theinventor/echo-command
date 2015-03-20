class SessionsController < ApplicationController
  before_filter :setup_oauth_client, only: [:smartthings_authorize, :smartthings_callback]
  before_filter :authenticate_user!, only: [:smartthings_authorize, :smartthings_callback, :set_code]

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

  def smartthings_authorize
    url = @client.auth_code.authorize_url(redirect_uri: @redirect_uri, scope: 'app')
    redirect_to url
  end

  def smartthings_callback
    response = @client.auth_code.get_token(params[:code], redirect_uri: @redirect_uri, scope: 'app')
    response.token
    current_user.store_oauth_code(params[:code])
    current_user.store_oauth_token(response.token)

    redirect_to root_path, notice: "Ok, we got you authorized to SmartThings too!"
  end

  def refresh_switches
    s = Smartthingr.new(current_user)
    LightSwitch.refresh_list(s.get_switches,current_user)
    redirect_to root_path, notice: "all set!"
  end


  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def setup_oauth_client
    client_id = ENV["SMARTTHINGS_OAUTH_CLIENT"]
    api_key = ENV["SMARTTHINGS_OAUTH_SECRET"]

    @redirect_uri = "#{Rails.env.production? ? "https://echo-command.herokuapp.com" : "http://twitter.lvh.me:4003"}/oauth/callback"

    options = {
        site: 'https://graph.api.smartthings.com',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/token'
    }

    @client = OAuth2::Client.new(client_id, api_key, options)

  end
end