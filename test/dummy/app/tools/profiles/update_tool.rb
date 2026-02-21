# frozen_string_literal: true

module Profiles
  class UpdateTool < ApplicationTool
    description "Update an existing profile and redirect to it on success; re-render form on validation failure."

    arguments do
      required(:id)
        .filled(:integer)
        .description("Profile id from the route.")
      required(:profile)
        .hash
        .description("Profile attributes. Nested fields: name (string), bio (string/text), active (bool).")
    end

    def call(id:, profile:)
      result = Ciaobrowser::Dispatcher.call(
        path: "/profiles/:id",
        method: "PUT",
        params: { id: id, profile: profile },
        user: current_user
      )

      result[:body]
    end
  end
end
