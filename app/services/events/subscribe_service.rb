# frozen_string_literal: true

module Events
  class SubscribeService

    def initialize(event:, user:)
      @event = event
      @user = user
    end

    def call
      create_subscription
      track_subscription_on_iterable

      true
    end

    private

    attr_reader :event, :user

    def create_subscription
      ApplicationRecord.transaction do
        event.lock!
        user.lock!

        user.events << event unless user.events.exists?(id: event.id)
      end
    end

    def track_subscription_on_iterable
      iterable_client = Iterable::Client.new

      response = iterable_client.events.track(
        iterable_event_id: event.iterable_event_id,
        iterable_user_id: user.iterable_user_id,
        event_name: event.name
      )

      event.update!(iterable_event_id: response['params']['id']) if event.iterable_event_id.blank?
    end

  end
end
