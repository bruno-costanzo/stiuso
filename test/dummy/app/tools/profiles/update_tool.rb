# frozen_string_literal: true

module Profiles
  class UpdateTool < ApplicationTool
    description "Updates the current user's profile with permitted profile params, then redirects to /profile on success or re-renders the edit form on failure."

    arguments do
      required(:profile)
        .hash
        .description("Profile attributes payload. Permitted nested keys: name (string), bio (string/text), active (bool).")
    end

    def call(profile:)
      result = Ciaobrowser::Dispatcher.call(
        path: "/profile",
        method: "PUT",
        params: { profile: profile },
        user: current_user
      )

      result[:body]
    end
  end
end
