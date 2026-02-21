# frozen_string_literal: true

module Profiles
  class DestroyTool < ApplicationTool
    description "Destroy a profile by id and redirect to the profiles list."

    arguments do
      required(:id)
        .filled(:integer)
        .description("Profile id from the route.")
    end

    def call(id:)
      result = Ciaobrowser::Dispatcher.call(
        path: "/profiles/:id",
        method: "DELETE",
        params: { id: id },
        user: current_user
      )

      result[:body]
    end
  end
end
