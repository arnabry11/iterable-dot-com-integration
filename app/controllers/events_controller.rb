# frozen_string_literal: true

class EventsController < ApplicationController

  before_action :authenticate_user!

  def subscribe
    event = Event.find(params[:id])
    create_event_subscription(event)
    flash[:notice] = "Successfully subscribed to #{event.name}"

    redirect_to root_path
  end

  private

  def create_event_subscription(event)
    ApplicationRecord.transaction do
      event.lock!
      current_user.lock!

      current_user.events << event unless current_user.events.exists?(id: event.id)
    end
  end

end
