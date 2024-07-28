# frozen_string_literal: true

class EventsController < ApplicationController

  before_action :authenticate_user!

  def subscribe
    event = Event.find(params[:id])
    Events::SubscribeService.new(event:, user: current_user).call
    flash[:notice] = "Successfully subscribed to #{event.name}"

    redirect_to root_path
  end

end
