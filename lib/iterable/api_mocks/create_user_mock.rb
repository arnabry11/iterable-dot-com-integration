# frozen_string_literal: true

module Iterable
  module ApiMocks
    class CreateUserMock

      def initialize(request)
        @request = request
      end

      def mock
        email = JSON.parse(request.request_body).dig('dataFields', 'email')

        if email.present?
          [200, {}, success_response_body(email).as_json]
        else
          [400, {}, {}.as_json]
        end
      end

      private

      attr_reader :request

      def success_response_body(email)
        {
          msg: 'User created successfully',
          code: 'Success',
          params: {
            email:,
            userId: SecureRandom.uuid
          }
        }
      end

    end
  end
end
