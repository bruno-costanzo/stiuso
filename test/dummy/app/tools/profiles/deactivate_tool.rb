# frozen_string_literal: true

module Profiles
  class DeactivateTool < ApplicationTool
    description "Deactivates the current user's profile by setting active=false, then redirects to /profile."

    def call
      result = Ciaobrowser::Dispatcher.call(
        path: "/profile/deactivate",
        method: "POST",
        params: {},
        user: current_user
      )

      result[:body]
    end
  end
end
