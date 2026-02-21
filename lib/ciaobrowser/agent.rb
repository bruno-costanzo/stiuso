# frozen_string_literal: true

require "ruby_llm/mcp"

module Ciaobrowser
  # AI agent that connects to the MCP server and executes tools on behalf of a user
  #
  # Example:
  #   agent = Ciaobrowser.agent(user: current_user)
  #   response = agent.ask("Show me all profiles")
  #   response = agent.ask("Update my profile with bio 'Hello world'")
  #
  class Agent
    attr_reader :user, :client

    def initialize(user:)
      @user = user
      @client = create_mcp_client
    end

    def ask(message)
      chat = RubyLLM.chat(model: Ciaobrowser.config.agent_model)
      chat.with_tools(*client.tools)
      chat.ask(message)
    end

    def tools
      client.tools
    end

    def stop
      client.stop
    end

    private

    def create_mcp_client
      RubyLLM::MCP.client(
        name: "ciaobrowser-#{user.id}",
        transport_type: :sse,
        config: {
          url: "#{Ciaobrowser.config.mcp_url}/sse",
          headers: build_headers
        }
      )
    end

    def build_headers
      {
        "x-user-id" => user.id.to_s
      }
    end
  end
end
