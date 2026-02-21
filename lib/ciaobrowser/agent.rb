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
    attr_reader :user, :client, :chat

    def initialize(user:)
      @user = user
      @client = create_mcp_client
      @chat = create_chat
    end

    def ask(message)
      chat.ask(message)
    end

    def tools
      client.tools
    end

    def stop
      client.stop
    end

    private

    def create_chat
      chat = RubyLLM.chat(model: Ciaobrowser.config.agent_model)
      chat.with_instructions(system_prompt)
      chat.with_tools(*client.tools)
      chat
    end

    def system_prompt
      base = Ciaobrowser.config.agent_system_prompt || default_system_prompt
      context = user_context

      context.empty? ? base : "#{base}\n\n## Current User Context\n#{context}"
    end

    def default_system_prompt
      <<~PROMPT
        You are an AI assistant that helps users interact with this application.
        You have access to tools that can read and modify data.
        Always act on behalf of the current user.
        When the user says "my" or "mine", they refer to their own data.
        Be concise and helpful.
      PROMPT
    end

    def user_context
      return "" unless Ciaobrowser.config.user_context

      Ciaobrowser.config.user_context.call(user)
    end

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
