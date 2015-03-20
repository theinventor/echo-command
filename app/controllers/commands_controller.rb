class CommandsController < ApplicationController
  protect_from_forgery except: :create

  def index
    puts "INDEX_PARAMS: #{params}"
    render text: "OK"
  end

  def create
    Rails.logger.debug "CREATE_PARAMS: #{params}"
    puts "CREATE_PARAMS: #{params}"


    @echo = setup_echo_device
    @intent = try_to_find_intent

    if @echo.authentication_id.blank?
      render json: say_registration_message(@intent) and return
    end

    if params[:session] && params[:session][:new]
      response = {
          version: '1',
          response: {
              outputSpeech: {
                  type: "PlainText", text: "Hi #{@echo.name}, welcome to your smart home."
              },
              shouldEndSession: false
          }
      }
      render json: response and return
    end

    if @intent == "LightsIntent"
      render json: reply_to_lights and return
    end

    if @intent == "PresenceIntent"
      render json: reply_to_presence and return
    end

    if params[:session] && params[:request]
      response = {
          version: '1',
          response: {
              outputSpeech: {
                  type: "PlainText", text: "Ok - you asked me to run a command!"
              },
              shouldEndSession: false
          }
      }
      render json: response and return
    end


    render text: "OK"
  end

  private

  def setup_echo_device
    EchoUser.find_or_create_by(device_id: params[:session][:user][:userId])
  end

  def try_to_find_intent
    if params[:request] && params[:request][:intent] && params[:request][:intent][:name]
      params[:request][:intent][:name]
    end
  end

  def say_registration_message(intent)
    if intent == "ReadyForCodeIntent"
      response = {
          version: '1',
          response: {
              outputSpeech: {
                  type: "PlainText",
                  text: "Your code to enter into the site is #{@echo.registration_code.split("").join(", ")}. Tell me you have entered it once you are done."
              },
              shouldEndSession: false
          }
      }
    else
      response = {
          version: '1',
          response: {
              outputSpeech: {
                  type: "PlainText",
                  text: "Hi There, welcome to Smart Things. It looks like you have not registered yet. Open a web browser and go
  to echo hyphen command dot herokuapp dot com and sign in. It will want you to enter your registration code. Tell me when you are ready
  for that code."
              },
              shouldEndSession: false
          }
      }
    end
  end

  def reply_to_lights
    command = params[:command][:request][:intent][:slots][:Command][:value]
    s = Smartthingr.new(@echo.user)
    s.change_lights(command)
    response = {
        version: '1',
        response: {
            outputSpeech: {
                type: "PlainText",
                text: "Got it - I will turn #{command} the lights now."
            },
            shouldEndSession: false
        }
    }
  end

  def reply_to_presence
    command = params[:command][:request][:intent][:slots][:Command][:value]
    response = {
        version: '1',
        response: {
            outputSpeech: {
                type: "PlainText",
                text: "Got it, you are #{command} - I will prepare the house for you."
            },
            shouldEndSession: false
        }
    }
  end


end