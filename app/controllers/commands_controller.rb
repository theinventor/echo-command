class CommandsController < ApplicationController
  protect_from_forgery except: :create

  def index
    puts "INDEX_PARAMS: #{params}"
    render text: "OK"
  end

  def create
    Rails.logger.debug "CREATE_PARAMS: #{params}"
    puts "CREATE_PARAMS: #{params}"

    if params[:session] && params[:session][:new]
      response = {
          version: '1',
          response: {
              outputSpeech: {
                  type: "PlainText", text: "Hi Troy, you opened the app, ask me to run command one or command two."
              },
              shouldEndSession: false
          }
      }
      render json: response and return
    end

    if params[:session] && params[:request]
      response = {
          version: '1',
          response: {
              outputSpeech: {
                  type: "PlainText", text: "Ok - you asked me to run a command!"
              },
              shouldEndSession: true
          }
      }
      render json: response and return
    end


    render text: "OK"
  end

end