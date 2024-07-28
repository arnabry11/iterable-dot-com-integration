# frozen_string_literal: true

module Iterable
  module Resource
    class Users < Base

      def create(email:)
        handle_response(
          client.post(
            '/api/users/update',
            { dataFields: { email: } }
          )
        ).body
      end

    end
  end
end
