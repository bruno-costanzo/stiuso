# frozen_string_literal: true

class Session < ApplicationRecord
  has_secure_token
  belongs_to :user
end
