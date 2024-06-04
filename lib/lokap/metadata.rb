# frozen_string_literal: true

# Ensure model has a jsonb metadata column:
#   t.jsonb :metadata, null: false, default: {}
#
module Lokap
  module Metadata
    extend ActiveSupport::Concern

    included do
      store_accessor :metadata, :logs
      after_initialize { self.logs ||= [] }
    end

    def log_metadata(message, flush: false)
      Rails.logger.info("Metadata Log: #{message}")
      ts_message = [Time.now.iso8601, message].join(': ')
      self.logs << ts_message
      save if flush
      message
    end
    alias_method :log_md, :log_metadata
  end
end
