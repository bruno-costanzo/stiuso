# frozen_string_literal: true

module Ciaobrowser
  module AgentTools
    # Reads controller source code
    class ReadController < RubyLLM::Tool
      description "Reads controller source code. " \
                  "Use this to understand actions and strong params."

      param :controller_name, type: "string",
                              desc: "Controller name without 'Controller' (e.g., 'profiles' or 'admin/profiles')"

      def execute(controller_name:)
        path = Rails.root.join("app", "controllers", "#{controller_name.underscore}_controller.rb")

        return { error: "Not found: #{path}" } unless File.exist?(path)

        File.read(path)
      end
    end
  end
end
