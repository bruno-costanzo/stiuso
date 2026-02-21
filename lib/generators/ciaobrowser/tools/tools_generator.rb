# frozen_string_literal: true

module Ciaobrowser
  module Generators
    # Generates MCP tools for a Rails controller using AI analysis
    class ToolsGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)
      argument :controller_name, type: :string

      desc "Generates MCP tools for the specified controller"

      def generate_tools
        say "Analyzing #{controller_name} controller...", :cyan

        tool_definitions = introspect_controller

        tool_definitions.each do |tool|
          generate_tool(tool)
        end

        generate_inspect_model_tool if model_class

        total = tool_definitions.size + (model_class ? 1 : 0)
        say ""
        say "Generated #{total} tools!", :green
      end

      private

      def introspect_controller
        agent = Ciaobrowser::Introspector.new(model: Ciaobrowser.config.generator_model)
        result = agent.ask("Analyze the #{controller_name} controller")

        result.content["tools"]
      end

      def generate_tool(tool)
        tool = tool.transform_keys(&:to_sym)

        @namespace = tool[:namespace]
        @class_name = tool[:class_name]
        @description = tool[:description]
        @http_method = tool[:http_method]
        @path = tool[:path]
        @params = tool[:params].map { |p| p.transform_keys(&:to_sym) }

        folder = @namespace.underscore
        template "tool.rb.tt", "app/tools/#{folder}/#{tool[:file_name]}"
      end

      def generate_inspect_model_tool
        @namespace = controller_name.camelize
        @model_name = model_class.name

        folder = @namespace.underscore
        template "inspect_model_tool.rb.tt", "app/tools/#{folder}/inspect_model_tool.rb"
      end

      def model_class
        @model_class ||= begin
          model_name = controller_name.singularize.camelize
          model_name.constantize
        rescue NameError
          nil
        end
      end
    end
  end
end
