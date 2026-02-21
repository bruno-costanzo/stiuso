# frozen_string_literal: true

require "zeitwerk"
require "ruby_llm"

# Auto-generate MCP tools from Rails controllers using AI
module Ciaobrowser
  class Error < StandardError; end

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Configuration.new
    end
  end
end

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")
loader.setup

require_relative "ciaobrowser/railtie" if defined?(Rails::Railtie)
