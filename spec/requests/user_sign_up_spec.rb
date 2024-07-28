# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Signup Flow' do
  it 'successfully creates the user' do
    post '/users', params: { user: { email: 'arnab@gmail.com', password: '123456', password_confirmation: '123456' } }

    expect(response).to have_http_status(:see_other)
    expect(response.headers['set-cookie']).not_to be_nil
    expect(User.last.iterable_user_id).not_to be_nil
  end
end
