# frozen_string_literal: true

module Iterable
  module ApiMocks
    class DeliverEmailMock

      def initialize(request)
        @request = request
      end

      def mock
        request_body = JSON.parse(request.request_body)
        target_iterable_user_id = request_body['recipientUserId']

        if target_iterable_user_id.present?
          [200, {}, success_response_body.as_json]
        else
          [400, {}, {}.as_json]
        end
      end

      private

      attr_reader :request

      def success_response_body
        {
          msg: 'Email sent successfully',
          code: 'Success',
          params: {}
        }
      end

    end
  end
end
