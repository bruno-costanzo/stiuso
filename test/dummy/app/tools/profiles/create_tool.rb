# frozen_string_literal: true

module Profiles
  class CreateTool < ApplicationTool
    description "Create a new profile and redirect to it on success; re-render form on validation failure."

    arguments do
      required(:profile)
        .hash
        .description("Profile attributes. Nested fields: name (string), bio (string/text), active (bool).")
    end

    def call(profile:)
      result = Ciaobrowser::Dispatcher.call(
        path: "/profiles",
        method: "POST",
        params: { profile: profile },
        user: current_user
      )

      result[:body]
    end
  end
end
