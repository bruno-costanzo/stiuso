# frozen_string_literal: true

module Profiles
  class ShowTool < ApplicationTool
    description "Shows the current user's profile (loads current_user.profile and renders show)."

    def call
      result = Ciaobrowser::Dispatcher.call(
        path: "/profile",
        method: "GET",
        params: {},
        user: current_user
      )

      result[:body]
    end
  end
end
