defmodule CozyCase.PascalCaseTest do
  use ExUnit.Case
  alias CozyCase.PascalCase

  describe "convert/1" do
    test "works for snake case" do
      assert "WelcomeMessage" = PascalCase.convert("welcome_message")
    end

    test "works for kebab case" do
      assert "WelcomeMessage" = PascalCase.convert("welcome-message")
    end

    test "works for camel case" do
      assert "WelcomeMessage" = PascalCase.convert("welcomeMessage")
    end

    test "works for pascal case" do
      assert "WelcomeMessage" = PascalCase.convert("WelcomeMessage")
    end
  end
end
