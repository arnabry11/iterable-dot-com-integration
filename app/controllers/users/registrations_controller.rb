# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController

    def create
      super

      CreateUserInIterableService.new(user: resource).call
    end

  end
end
