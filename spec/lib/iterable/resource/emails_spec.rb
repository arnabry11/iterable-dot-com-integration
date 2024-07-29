# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Iterable::Resource::Emails do
  let(:emails) { Iterable::Client.new.emails }

  describe 'create' do
    context 'when valid recipient user id is given' do
      it 'creates a user' do
        response = emails.deliver(recipient_user_id: SecureRandom.uuid)

        expect(response['code']).to eq('Success')
      end
    end

    context 'when invalid email is passed' do
      it 'throws error' do
        expect do
          emails.deliver(recipient_user_id: '')
        end.to raise_error(described_class::BadRequestError)
      end
    end
  end
end
