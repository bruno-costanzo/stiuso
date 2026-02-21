# frozen_string_literal: true

module Ciaobrowser
  # AI agent that analyzes Rails controllers and returns tool definitions
  class Introspector < RubyLLM::Agent
    tools Ciaobrowser::AgentTools::ReadRoutes,
          Ciaobrowser::AgentTools::ReadController,
          Ciaobrowser::AgentTools::ReadModel

    schema Ciaobrowser::Schemas::ToolDefinitions

    instructions <<~PROMPT
      You analyze Rails controllers and return structured data for MCP tool generation.

      For each controller:
      1. Use read_routes to discover available actions
      2. Use read_controller to understand the implementation
      3. Use read_model (singular of controller name) for param types

      Return a ToolDefinitions schema with one tool per action.
      Skip 'new' and 'edit' actions (they just render forms).

      NAMING CONVENTIONS:
      - namespace: Controller name as module (e.g., "Profiles" for ProfilesController)
      - class_name: Action + "Tool" (e.g., "ShowTool", "UpdateTool", "CreateTool")
      - file_name: Action + "_tool.rb" (e.g., "show_tool.rb", "update_tool.rb")

      This creates: app/tools/profiles/show_tool.rb with class Profiles::ShowTool

      PARAMETER RULES:
      - All param names MUST be valid Ruby identifiers (snake_case, no dots)
      - For route params like :id, use type "integer"
      - For nested Rails params like profile[name], use a SINGLE param:
        - name: "profile" (the parent key)
        - type: "hash"
        - description: describe all nested fields
      - Do NOT create separate params for each nested field
      - Use "bool" for boolean type (not "boolean")

      Examples:
      - Route /profiles/:id → param: { name: "id", type: "integer", required: true }
      - POST with profile[name], profile[bio] → param: { name: "profile", type: "hash", required: true }
    PROMPT
  end
end
