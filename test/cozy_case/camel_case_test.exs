defmodule CozyCase.CamelCaseTest do
  use ExUnit.Case
  alias CozyCase.CamelCase

  describe "convert/1" do
    test "works for snake case" do
      assert "welcomeMessage" = CamelCase.convert("welcome_message")
    end

    test "works for kebab case" do
      assert "welcomeMessage" = CamelCase.convert("welcome-message")
    end

    test "works for camel case" do
      assert "welcomeMessage" = CamelCase.convert("welcomeMessage")
    end

    test "works for pascal case" do
      assert "welcomeMessage" = CamelCase.convert("WelcomeMessage")
    end
  end
end
