defmodule CozyCaseTest do
  use ExUnit.Case
  doctest CozyCase

  test "greets the world" do
    assert CozyCase.hello() == :world
  end
end
