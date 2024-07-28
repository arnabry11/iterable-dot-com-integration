# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User subscribes to event' do
  let(:user) { create(:user, :with_iterable_user_id) }
  let(:event) { create(:event) }

  it 'successfully creates a subscription for user' do
    sign_in user
    post "/events/#{event.id}/subscribe"

    expect(response).to have_http_status(:found)
    expect(user.events).to contain_exactly(event)
    expect(event.reload.iterable_event_id).not_to be_nil
  end
end
