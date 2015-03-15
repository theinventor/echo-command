class CommandsController < ApplicationController

  def index
    puts "PARAMS: #{params}"
    render text: "OK"
  end

end