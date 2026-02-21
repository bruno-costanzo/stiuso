# frozen_string_literal: true

require "test_helper"

class TestCiaobrowser < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ciaobrowser::VERSION
  end

  def test_error_class_exists
    assert_equal Ciaobrowser::Error.superclass, StandardError
  end
end
