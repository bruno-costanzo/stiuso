# frozen_string_literal: true

require "test_helper"

class TestConfiguration < Minitest::Test
  def setup
    @config = Ciaobrowser::Configuration.new
  end

  def test_default_generator_model
    assert_equal "claude-sonnet-4-20250514", @config.generator_model
  end

  def test_default_resolve_user_is_nil
    assert_nil @config.resolve_user
  end

  def test_generator_model_is_configurable
    @config.generator_model = "gpt-4o"

    assert_equal "gpt-4o", @config.generator_model
  end

  def test_resolve_user_is_configurable
    resolver = ->(headers) { headers&.dig("x-user-id") }
    @config.resolve_user = resolver

    assert_equal resolver, @config.resolve_user
    assert_equal "123", @config.resolve_user.call({ "x-user-id" => "123" })
  end

  def test_configure_block
    Ciaobrowser.configure do |config|
      config.generator_model = "test-model"
    end

    assert_equal "test-model", Ciaobrowser.config.generator_model
  end

  def test_config_returns_same_instance
    config1 = Ciaobrowser.config
    config2 = Ciaobrowser.config

    assert_same config1, config2
  end
end
