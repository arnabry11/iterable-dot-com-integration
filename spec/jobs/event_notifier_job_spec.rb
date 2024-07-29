# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventNotifierJob do
  let(:job) { described_class.new }
  let(:emails) { instance_double(Iterable::Resource::Emails) }
  let(:iterable_client) { instance_double(Iterable::Client, emails:) }

  let(:event1) { create(:event, name: 'Event-A') }
  let(:event2) { create(:event, name: 'Event-B') }

  let(:user1) { create(:user, :with_iterable_user_id) }
  let(:user2) { create(:user, :with_iterable_user_id) }
  let(:user3) { create(:user, :with_iterable_user_id) }

  before do
    # subscribing to event1
    user1.events << event1
    user2.events << event1

    # subscribing to event2
    user3.events << event2

    job.instance_variable_set(:@iterable_client, iterable_client)
  end

  it 'sends emails to users who are subscribed to Event-B' do
    expect(emails).to receive(:deliver).with(recipient_user_id: user3.iterable_user_id)
    expect(emails).not_to receive(:deliver).with(recipient_user_id: user1.iterable_user_id)
    expect(emails).not_to receive(:deliver).with(recipient_user_id: user2.iterable_user_id)

    job.perform
  end
end
