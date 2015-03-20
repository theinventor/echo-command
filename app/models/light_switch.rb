class LightSwitch < ActiveRecord::Base

  def self.refresh_list(switches=[],user)
    switches.keys.each do |switch|
      user.light_switches.find_or_create_by(name: switch)
    end
  end
end
