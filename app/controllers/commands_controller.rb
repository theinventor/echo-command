class CommandsController < ApplicationController
  protect_from_forgery except: :create

  def index
    puts "INDEX_PARAMS: #{params}"
    render text: "OK"
  end

  def create
    Rails.logger.debug "CREATE_PARAMS: #{params}"

    if params[:session] && params[:session][:new]
      response = {
          version: '1',
          response: {
              outputSpeech: {
                  type: "PlainText", text: "Hi Troy, you opened the app!"
              },
              shouldEndSession: true
          }
      }
      render json: response and return

    end


    render text: "OK"
  end

end