# frozen_string_literal: true

module Iterable
  class Client

    def initialize(config = { url: 'https://api.iterable.com/api', api_key: 'test' })
      @url = config.fetch(:url)
      @api_key = config.fetch(:api_key)
    end

    def get(url, params = {}, _headers = {})
      connection.get url, params
    end

    def post(url, params = {}, headers = {})
      connection.post url, params, headers
    end

    private

    attr_reader :url, :api_key

    def connection
      @connection = Faraday.new(url:) do |conn|
        conn.request :authorization, 'Bearer', api_key
        conn.request :retry
        conn.request :multipart
        conn.request :json

        conn.response :json
        conn.response :follow_redirects
        conn.response :raise_error

        conn.adapter :test do |stub|
          stub.get('/hello') { |_request| [200, {}, { test: 'Hello World' }.as_json] }
        end
      end
    end

  end
end
