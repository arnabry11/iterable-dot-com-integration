# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::CreateUserInIterableService do
  let(:user) { create(:user) }

  it 'updates the iterable user id' do
    described_class.new(user:).call

    expect(user.reload.iterable_user_id).not_to be_nil
  end
end
