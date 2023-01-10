defmodule CozyCase.SnakeCaseTest do
  use ExUnit.Case
  alias CozyCase.SnakeCase

  describe "convert/1" do
    test "works for snake case" do
      assert "welcome_message" = SnakeCase.convert("welcome_message")
    end

    test "works for kebab case" do
      assert "welcome_message" = SnakeCase.convert("welcome-message")
    end

    test "works for camel case" do
      assert "welcome_message" = SnakeCase.convert("welcomeMessage")
    end

    test "works for pascal case" do
      assert "welcome_message" = SnakeCase.convert("WelcomeMessage")
    end
  end
end
