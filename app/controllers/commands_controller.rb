class CommandsController < ApplicationController
  protect_from_forgery except: :create

  def index
    puts "INDEX_PARAMS: #{params}"
    render text: "OK"
  end

  def create
    Rails.logger.debug "CREATE_PARAMS: #{params}"
    render text: "OK"
  end

end