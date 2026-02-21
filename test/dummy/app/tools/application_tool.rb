# frozen_string_literal: true

class ApplicationTool < ActionTool::Base
  private

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = Ciaobrowser.config.resolve_user&.call(@headers)
  end
end
