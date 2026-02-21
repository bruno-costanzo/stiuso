# frozen_string_literal: true

module Profiles
  class DestroyTool < ApplicationTool
    description "Destroys the current user's profile and redirects to the root path."

    def call
      result = Ciaobrowser::Dispatcher.call(
        path: "/profile",
        method: "DELETE",
        params: {},
        user: current_user
      )

      result[:body]
    end
  end
end
