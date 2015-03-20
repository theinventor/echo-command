class Smartthingr

  attr_accessor :conn

  def initialize(user)
    @user = user
    @token = user.authentication.oauth_token
    @conn = Faraday.new
    @conn.headers = {"Authorization" => "Bearer #{@token}"}
    @base_url = "https://graph.api.smartthings.com"
    get_apps
  end

  def get_apps
    endpoint = "https://graph.api.smartthings.com/api/smartapps/endpoints"
    r = @conn.get endpoint
    if r.status == 200
      body = JSON.parse r.body
      if body.first
        @st_url =  body.first['url']
      end
    else
      puts "BAD #{r}"
    end
  end


  def get_switches
    switches = JSON.parse @conn.get("#{@base_url}#{@st_url}/switch").body
  end

  def change_mode(command="Home")
    result = @conn.post "#{@base_url}#{@st_url}/mode?command=#{command}"
  end

  def change_lights(command)

    lights = @user.light_switches

    if command == 'on'
      lights = lights.where(turn_on: true)
    else
      lights = lights.where(turn_off: true)
    end

    lights.map(&:name).each do |light|
      r = @conn.post "#{@base_url}#{@st_url}/switch?deviceId=#{light}&command=#{command}"
    end
  end


end