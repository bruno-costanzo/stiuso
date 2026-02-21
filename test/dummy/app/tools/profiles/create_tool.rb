# frozen_string_literal: true

module Profiles
  class CreateTool < ApplicationTool
    description "Creates a profile for the current user using permitted profile params, then redirects to /profile on success or re-renders the new form on failure."

    arguments do
      required(:profile)
        .hash
        .description("Profile attributes payload. Permitted nested keys: name (string), bio (string/text), active (bool).")
    end

    def call(profile:)
      result = Ciaobrowser::Dispatcher.call(
        path: "/profile",
        method: "POST",
        params: { profile: profile },
        user: current_user
      )

      result[:body]
    end
  end
end
