class Smartthingr

  def initialize(user)
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

  def get_info(url)
    conn = Faraday.new
    conn.headers = {"Authorization" => "Bearer #{token}"}
    conn.headers['Content-Type'] = 'application/json'
    base_url = "https://graph.api.smartthings.com"
    conn.get "#{base_url}#{@st_url}"
  end

  def change_lights(command)
    lights = ["Master","Dining Room", "Kitchen","Garage Lights", "Upstairs Hall"]
    lights.each do |light|
      r = @conn.post "#{@base_url}#{@st_url}/switch?deviceId=#{light}&command=#{command}"
    end
  end


end