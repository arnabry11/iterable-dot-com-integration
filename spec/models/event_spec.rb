# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event do
  describe '#validations' do
    subject(:event) { build(:event) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_length_of(:iterable_event_id).is_at_most(36) }
  end
end
