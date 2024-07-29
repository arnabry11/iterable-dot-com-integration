# frozen_string_literal: true

module Iterable
  module ApiMocks
    class TrackEventMock

      def initialize(request)
        @request = request
      end

      def mock
        request_body = JSON.parse(request.request_body)
        event_name = request_body['eventName']
        iterable_user_id = request_body['userId']
        iterable_event_id = request_body['id']

        if event_name.present? && iterable_user_id.present?
          [200, {}, success_response_body(event_name, iterable_user_id, iterable_event_id).as_json]
        else
          [400, {}, {}.as_json]
        end
      end

      private

      attr_reader :request

      def success_response_body(event_name, iterable_user_id, iterable_event_id)
        user = User.find_by!(iterable_user_id:)

        {
          msg: 'Event tracked successfully',
          code: 'Success',
          params: {
            email: user.email,
            userId: user.iterable_user_id,
            id: iterable_event_id.presence || SecureRandom.uuid,
            eventName: event_name
          }
        }
      end

    end
  end
end
