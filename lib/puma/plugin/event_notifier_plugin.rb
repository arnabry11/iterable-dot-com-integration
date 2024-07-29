# frozen_string_literal: true

# lib/puma/plugin/refresh_feed.rb

require 'puma/plugin'

Puma::Plugin.create do
  attr_reader :log_writer

  def start(launcher)
    @log_writer = launcher.log_writer

    in_background do
      loop do
        sleep 10
        log 'Sending notifications for required events'
        EventNotifierJob.perform_later
      end
    end
  end

  private

  def log(...)
    log_writer.log(...)
  end
end
