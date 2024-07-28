# frozen_string_literal: true

class Event < ApplicationRecord

  has_and_belongs_to_many :users # rubocop:disable Rails/HasAndBelongsToMany

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :iterable_event_id, length: { maximum: 36 }

end
