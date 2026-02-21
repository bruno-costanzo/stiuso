# frozen_string_literal: true

module Ciaobrowser
  module AgentTools
    # Reads Rails routes for a controller
    class ReadRoutes < RubyLLM::Tool
      description "Returns all routes for a controller. " \
                  "Use this first to discover what actions exist."

      param :controller_name, type: "string",
                              desc: "Controller name without 'Controller' (e.g., 'profiles' or 'admin/profiles')"

      def execute(controller_name:)
        routes = Rails.application.routes.routes.select do |route|
          route.defaults[:controller] == controller_name.underscore
        end

        routes.map do |route|
          {
            action: route.defaults[:action],
            method: route.verb,
            path: route.path.spec.to_s.sub("(.:format)", "")
          }
        end
      end
    end
  end
end
