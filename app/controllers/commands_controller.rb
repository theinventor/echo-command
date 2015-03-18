class CommandsController < ApplicationController

  def index
    puts "INDEX_PARAMS: #{params}"
    render text: "OK"
  end

  def create
    puts "CREATE_PARAMS: #{params}"
    render text: "OK"
  end

end