# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::SubscribeService do
  let(:event) { create(:event) }
  let(:user) { create(:user, :with_iterable_user_id) }

  it 'updates the iterable user id' do
    described_class.new(user:, event:).call

    expect(event.reload.iterable_event_id).not_to be_nil
    expect(user.events).to contain_exactly(event)
  end
end
