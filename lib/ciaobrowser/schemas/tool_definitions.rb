# frozen_string_literal: true

require "ruby_llm/schema"

module Ciaobrowser
  module Schemas
    # Schema for structured output: list of tools to generate for a controller
    class ToolDefinitions < RubyLLM::Schema
      name "tool_definitions"
      description "List of tools to generate for a controller"

      array :tools, of: Ciaobrowser::Schemas::ToolDefinition, required: true
    end
  end
end
