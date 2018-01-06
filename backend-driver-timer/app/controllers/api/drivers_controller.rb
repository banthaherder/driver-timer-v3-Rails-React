class Api::DriversController < ApplicationController
  def index
    @store = Store.where(:store_number => params[:store_id]).first
    @drivers = @store.drivers
    json_response(@drivers)
  end

  def show
    @driver = Driver.find(params[:id])
    json_response(@driver)
  end

  def last_message
    @driver = Driver.find(params[:driver_id])
    @last_message = @driver.messages.last
    json_response(@last_message)
  end
end
