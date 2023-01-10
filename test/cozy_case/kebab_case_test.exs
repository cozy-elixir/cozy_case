defmodule CozyCase.KebabCaseTest do
  use ExUnit.Case
  alias CozyCase.KebabCase

  describe "convert/1" do
    test "works for snake case" do
      assert "welcome-message" = KebabCase.convert("welcome_message")
    end

    test "works for kebab case" do
      assert "welcome-message" = KebabCase.convert("welcome-message")
    end

    test "works for camel case" do
      assert "welcome-message" = KebabCase.convert("welcomeMessage")
    end

    test "works for pascal case" do
      assert "welcome-message" = KebabCase.convert("WelcomeMessage")
    end
  end
end
