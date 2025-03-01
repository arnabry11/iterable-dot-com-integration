# frozen_string_literal: true

class User < ApplicationRecord

  has_and_belongs_to_many :events # rubocop:disable Rails/HasAndBelongsToMany

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :subscribed_to_event, lambda { |event_name|
    joins(:events).where(events: { name: event_name })
  }

end
