# frozen_string_literal: true

module Ciaobrowser
  # Global configuration for Ciaobrowser
  class Configuration
    attr_accessor :generator_model,
                  :authenticate_request,
                  :resolve_user

    def initialize
      @generator_model = ENV.fetch("GENERATOR_MODEL", "claude-sonnet-4-20250514")
      @authenticate_request = nil
      @resolve_user = nil
    end
  end
end
