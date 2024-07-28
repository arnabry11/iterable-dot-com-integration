# frozen_string_literal: true

module Iterable
  module Resource
    class Base

      Error = Class.new(StandardError)
      NotFoundError = Class.new(Error)
      ModelInvalidError = Class.new(Error)
      BadRequestError = Class.new(Error)
      UnauthorizedError = Class.new(Error)

      def initialize(client)
        @client = client
      end

      private

      attr_reader :client

      def handle_response(response)
        case response.status
        when 400
          raise BadRequestError
        when 401
          raise UnauthorizedError
        when 404
          raise NotFoundError
        end

        response
      end

    end
  end
end
