# frozen_string_literal: true

require "ruby_llm/schema"

module Ciaobrowser
  module Schemas
    class ToolParam < RubyLLM::Schema
      name "tool_param"

      string :name, required: true,
                    description: "Parameter name (valid Ruby identifier, snake_case)"
      string :type, required: true,
                    enum: %w[string integer bool hash],
                    description: "Parameter type (use 'hash' for nested params like profile)"
      boolean :required, required: true
      string :description, required: true
    end
  end
end
