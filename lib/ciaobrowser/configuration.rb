# frozen_string_literal: true

module Ciaobrowser
  # Global configuration for Ciaobrowser
  class Configuration
    attr_accessor :generator_model,
                  :authenticate_request,
                  :resolve_user,
                  :mcp_url,
                  :agent_model

    def initialize
      @generator_model = ENV.fetch("GENERATOR_MODEL", "claude-sonnet-4-20250514")
      @authenticate_request = nil
      @resolve_user = nil
      @mcp_url = ENV.fetch("MCP_URL", "http://localhost:3000/mcp")
      @agent_model = ENV.fetch("AGENT_MODEL", "claude-sonnet-4-20250514")
    end
  end
end
