# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User subscribes to event' do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  it 'successfully creates a subscription for user' do
    sign_in user
    post "/events/#{event.id}/subscribe"

    expect(response).to have_http_status(:found)
    expect(user.events).to contain_exactly(event)
  end
end
