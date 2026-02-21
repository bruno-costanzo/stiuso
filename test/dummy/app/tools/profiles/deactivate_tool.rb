# frozen_string_literal: true

module Profiles
  class DeactivateTool < ApplicationTool
    description "Deactivate a profile by setting active=false, then redirect to the profile."

    arguments do
      required(:id)
        .filled(:integer)
        .description("Profile id from the route.")
    end

    def call(id:)
      result = Ciaobrowser::Dispatcher.call(
        path: "/profiles/:id/deactivate",
        method: "POST",
        params: { id: id },
        user: current_user
      )

      result[:body]
    end
  end
end
