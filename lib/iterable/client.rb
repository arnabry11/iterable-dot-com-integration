# frozen_string_literal: true

module Iterable
  class Client

    def initialize(config = { url: 'https://api.iterable.com', api_key: 'test' })
      @url = config.fetch(:url)
      @api_key = config.fetch(:api_key)
    end

    def get(url, params = {}, _headers = {})
      connection.get url, params
    end

    def post(url, params = {}, headers = {})
      connection.post url, params, headers
    end

    def users
      Resource::Users.new(self)
    end

    def events
      Resource::Events.new(self)
    end

    def emails
      Resource::Emails.new(self)
    end

    private

    attr_reader :url, :api_key

    def connection
      @connection = Faraday.new(url:) do |conn|
        conn.request :retry
        conn.request :multipart
        conn.request :json

        conn.response :json
        conn.response :follow_redirects

        conn.adapter :test do |stub|
          mock_mappings = YAML.safe_load(Rails.root.join('lib', 'iterable', 'api_mock_mappings.yml').read)

          mock_mappings['iterable'].each_value do |mocking_details|
            method = mocking_details['method']
            path = mocking_details['path']
            handler_class = "::Iterable::ApiMocks::#{mocking_details['handler']}"

            stub.public_send(method.to_sym, path) { |request| handler_class.constantize.new(request).mock }
          end
        end
      end
    end

  end
end
