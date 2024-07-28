# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Iterable::Resource::Users do
  let(:users) { Iterable::Client.new.users }

  describe 'create' do
    context 'when valid email is given' do
      it 'creates a user' do
        user = users.create(email: 'test@gmail.com')['params']

        expect(user['email']).to eq('test@gmail.com')
        expect(user['userId']).not_to be_nil
      end
    end

    context 'when invalid email is passed' do
      it 'throws error' do
        expect do
          users.create(email: '')
        end.to raise_error(described_class::BadRequestError)
      end
    end
  end
end
