# frozen_string_literal: true

module Users
  class CreateUserInIterableService

    def initialize(user:)
      @user = user
    end

    def call
      iterable_client = Iterable::Client.new
      iterable_user_id = iterable_client.users.create(email: user.email)['params']['userId']

      ApplicationRecord.transaction do
        user.lock!

        user.update!(iterable_user_id:) unless user.iterable_user_id
      end

      user
    end

    private

    attr_reader :user

  end
end
