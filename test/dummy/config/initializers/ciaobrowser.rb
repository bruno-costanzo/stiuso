# frozen_string_literal: true

Ciaobrowser.configure do |config|
  config.generator_model = ENV.fetch("GENERATOR_MODEL", "gpt-4o")

  config.resolve_user = lambda { |headers|
    user_id = headers&.dig("x-user-id")
    User.find_by(id: user_id) if user_id
  }

  config.authenticate_request = lambda { |env, user|
    session = user.sessions.first_or_create!(
      user_agent: "ciaobrowser",
      ip_address: "127.0.0.1"
    )
    env["HTTP_AUTHORIZATION"] = "Bearer #{session.token}"
  }
end
