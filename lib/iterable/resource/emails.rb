# frozen_string_literal: true

module Iterable
  module Resource
    class Emails < Base

      ITERABLE_CAMPAIGN_ID = 26

      def deliver(recipient_user_id:, data_fields: {})
        handle_response(
          client.post(
            '/api/email/target',
            {
              campaignId: ITERABLE_CAMPAIGN_ID,
              recipientUserId: recipient_user_id,
              dataFields: data_fields
            }
          )
        ).body
      end

    end
  end
end
