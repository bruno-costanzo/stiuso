# frozen_string_literal: true

module Profiles
  class ShowTool < ApplicationTool
    description "Fetch and display a single profile by id."

    arguments do
      required(:id)
        .filled(:integer)
        .description("Profile id from the route.")
    end

    def call(id:)
      result = Ciaobrowser::Dispatcher.call(
        path: "/profiles/:id",
        method: "GET",
        params: { id: id },
        user: current_user
      )

      result[:body]
    end
  end
end
