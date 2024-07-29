# frozen_string_literal: true

class ApplicationController < ActionController::Base

  rescue_from StandardError do
    render text: 'Internal server error.', status: :internal_server_error
  end

end
