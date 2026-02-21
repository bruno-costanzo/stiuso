# frozen_string_literal: true

module Ciaobrowser
  module Generators
    # Sets up ciaobrowser in a Rails application
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Installs ciaobrowser: sets up fast-mcp and creates the initializer"

      def run_fast_mcp_install
        return if File.exist?("config/initializers/fast_mcp.rb")

        generate "fast_mcp:install"
      end

      def create_ruby_llm_initializer
        return if File.exist?("config/initializers/ruby_llm.rb")

        template "ruby_llm.rb.tt", "config/initializers/ruby_llm.rb"
      end

      def create_initializer
        template "ciaobrowser.rb.tt", "config/initializers/ciaobrowser.rb"
      end

      def create_application_tool
        return if File.exist?("app/tools/application_tool.rb")

        template "application_tool.rb.tt", "app/tools/application_tool.rb"
      end

      def show_next_steps
        say ""
        say "ciaobrowser installed!", :green
        say ""
        say "Next steps:"
        say "  1. Set your API keys in ENV (ANTHROPIC_API_KEY, OPENAI_API_KEY, etc.)"
        say "  2. Configure resolve_user in config/initializers/ciaobrowser.rb"
        say "  3. Run: rails generate ciaobrowser:tools <controller_name>"
        say ""
      end
    end
  end
end
