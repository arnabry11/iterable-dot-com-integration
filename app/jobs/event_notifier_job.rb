class EventNotifierJob < ApplicationJob

  NOTIFIABLE_EVENT_NAME = 'Event-B'.freeze

  def perform
    User.subscribed_to_event(NOTIFIABLE_EVENT_NAME).find_each do |user|
      iterable_client.emails.deliver(recipient_user_id: user.iterable_user_id)
    end
  end

  private

  def iterable_client
    @iterable_client ||= Iterable::Client.new
  end

end
