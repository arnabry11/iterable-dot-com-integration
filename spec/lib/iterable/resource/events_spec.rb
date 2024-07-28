# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Iterable::Resource::Events do
  let(:events) { Iterable::Client.new.events }

  describe 'track' do
    context 'when valid params are passed' do
      let(:user) { create(:user, :with_iterable_user_id) }

      it 'associates the user to event' do
        response = events.track(
          event_name: 'Event-A',
          iterable_user_id: user.iterable_user_id
        )

        params = response['params']

        expect(params['email']).to eq(user.email)
        expect(params['id']).not_to be_nil
      end
    end

    context 'when invalid params are passed' do
      it 'throws error' do
        expect do
          events.track(event_name: nil, iterable_user_id: nil)
        end.to raise_error(described_class::BadRequestError)
      end
    end
  end
end
