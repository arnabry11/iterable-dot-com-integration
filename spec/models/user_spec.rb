# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '.scopes' do
    describe 'subscribed_to_event' do
      let(:event1) { create(:event, name: 'Event-A') }
      let(:event2) { create(:event, name: 'Event-B') }

      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let(:user3) { create(:user) }

      before do
        # subscribing to event1
        user1.events << event1
        user2.events << event1

        # subscribing to event2
        user3.events << event2
      end

      it 'returns users subscribed to given event name' do
        results = described_class.subscribed_to_event(event1.name)
        expect(results).to contain_exactly(user1, user2)

        results = described_class.subscribed_to_event(event2.name)
        expect(results).to contain_exactly(user3)
      end
    end
  end
end
