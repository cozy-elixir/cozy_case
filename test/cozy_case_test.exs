defmodule CozyCaseTest do
  use ExUnit.Case

  doctest CozyCase

  describe "snake_case/1" do
    test "works for strings" do
      assert "welcome_message" = CozyCase.snake_case("WelcomeMessage")
    end

    test "works for atoms" do
      assert "welcome_message" = CozyCase.snake_case(:WelcomeMessage)
    end

    test "works for maps and lists" do
      assert %{
               "name" => "Lenna",
               "age" => 23,
               "hobbies" => ["Fishing", "Singing"],
               "family_members" => %{
                 "father" => %{
                   "name" => "Charlie",
                   "age" => 55,
                   "hobbies" => ["Hacking", "Singing"]
                 },
                 "mother" => %{
                   "name" => "Lily",
                   "age" => 50,
                   "hobbies" => ["Dreaming", "Singing"]
                 }
               }
             } ==
               CozyCase.snake_case(%{
                 "Name" => "Lenna",
                 "Age" => 23,
                 "Hobbies" => ["Fishing", "Singing"],
                 "FamilyMembers" => %{
                   mother: %{
                     "Name" => "Lily",
                     "Age" => 50,
                     "Hobbies" => ["Dreaming", "Singing"]
                   },
                   father: %{
                     "Name" => "Charlie",
                     "Age" => 55,
                     "Hobbies" => ["Hacking", "Singing"]
                   }
                 }
               })
    end
  end

  describe "kebab_case/1" do
    # NO NEED TO TEST
  end

  describe "camel_case/1" do
    # NO NEED TO TEST
  end

  describe "pascal_case/1" do
    # NO NEED TO TEST
  end
end
