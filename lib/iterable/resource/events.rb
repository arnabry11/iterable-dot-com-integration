# frozen_string_literal: true

module Iterable
  module Resource
    class Events < Base

      def track(iterable_user_id:, event_name:, iterable_event_id: nil)
        handle_response(
          client.post(
            '/api/events/track',
            build_payload(iterable_event_id:, iterable_user_id:, event_name:)
          )
        ).body
      end

      private

      def build_payload(iterable_event_id:, iterable_user_id:, event_name:)
        payload = {
          userId: iterable_user_id,
          eventName: event_name
        }

        payload.merge(id: iterable_event_id) if iterable_event_id

        payload
      end

    end
  end
end
