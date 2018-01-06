class InboundMessagesController < ApplicationController
  def create
    driver_phone_number = params["msisdn"]
    driver_id = Driver.where(:phone_number => driver_phone_number).first.id

    @new_message = Message.new(:from => driver_phone_number,:text => params["text"],:message_id => params["messageId"],:message_timestamp => params["message-timestamp"], :driver_id => driver_id)

    if @new_message.save!
      ActionCable.server.broadcast 'messages',
      new_message: @new_message
      # No render but still let server know it's all good
      head :ok
      # @new_driver_message = DriverMessage.new(:driver_id =>  driver_id, :message_id => message.id)
      # if @new_driver_message.save!
      #   ActionCable.server.broadcast 'messages',
      #   new_driver_message: @new_driver_message
      #   # No render but still let server know it's all good
      #   head :ok
      # end
    end
  end

private
  # Eventually I want to move the sms creation down here.
  def sms_params

  end
end
