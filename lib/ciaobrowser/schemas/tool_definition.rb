# frozen_string_literal: true

require "ruby_llm/schema"

module Ciaobrowser
  module Schemas
    class ToolDefinition < RubyLLM::Schema
      name "tool_definition"
      description "Definition of an MCP tool to generate"

      string :namespace, required: true,
                         description: "Module namespace from controller (e.g., Profiles for ProfilesController)"
      string :class_name, required: true,
                          description: "Tool class name without namespace (e.g., UpdateTool)"
      string :file_name, required: true,
                         description: "File name without folder (e.g., update_tool.rb)"
      string :description, required: true,
                           description: "What this tool does for the AI"
      string :action, required: true,
                      description: "Rails action name (show, update, destroy)"
      string :http_method, required: true,
                           description: "HTTP verb"
      string :path, required: true,
                    description: "Route path"

      array :params, of: Ciaobrowser::Schemas::ToolParam, required: true
    end
  end
end
