# frozen_string_literal: true

module Ciaobrowser
  # Executes controller actions programmatically with user context
  #
  # This is the bridge between MCP tools and Rails controllers.
  # It builds a Rack environment, injects authentication, and calls
  # the Rails router directly (bypassing middleware to avoid deadlocks).
  #
  # Example:
  #   Ciaobrowser::Dispatcher.call(
  #     path: "/profiles/:id",
  #     method: "GET",
  #     params: { id: 1 },
  #     user: current_user
  #   )
  class Dispatcher
    def self.call(path:, method: "GET", params: {}, user: nil)
      new(path, method, params, user).call
    end

    def initialize(path, method, params, user)
      @path_template = path
      @method = method.to_s.upcase
      @params = params.transform_keys(&:to_sym)
      @user = user
    end

    def call
      reset_current_attributes
      env = build_rack_env
      inject_mcp_header(env)
      inject_authentication(env)

      status, _headers, body = Rails.application.routes.call(env)

      extract_body(status, body)
    end

    def reset_current_attributes
      ActiveSupport::CurrentAttributes.descendants.each(&:reset)
    end

    private

    def build_rack_env
      Rack::MockRequest.env_for(
        resolved_path,
        method: @method,
        params: remaining_params
      )
    end

    def resolved_path
      @path_template.gsub(/:(\w+)/) do
        param_name = ::Regexp.last_match(1).to_sym
        @params.fetch(param_name)
      end
    end

    def remaining_params
      path_param_names = @path_template.scan(/:(\w+)/).flatten.map(&:to_sym)
      @params.except(*path_param_names)
    end

    def inject_mcp_header(env)
      env["HTTP_X_MCP_REQUEST"] = "true"
    end

    def inject_authentication(env)
      return unless @user
      return unless Ciaobrowser.config.authenticate_request

      Ciaobrowser.config.authenticate_request.call(env, @user)
    end

    def extract_body(status, body)
      content = body.respond_to?(:body) ? body.body : body.join

      { status: status, body: content }
    end
  end
end
