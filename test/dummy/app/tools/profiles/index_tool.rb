# frozen_string_literal: true

module Profiles
  class IndexTool < ApplicationTool
    description "List all profiles."

    def call
      result = Ciaobrowser::Dispatcher.call(
        path: "/profiles",
        method: "GET",
        params: {},
        user: current_user
      )

      result[:body]
    end
  end
end
