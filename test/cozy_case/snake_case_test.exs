defmodule CozyCase.SnakeCaseTest do
  use ExUnit.Case
  alias CozyCase.SnakeCase

  describe "convert/1" do
    test "works for snake case" do
      assert "good_html_page" = SnakeCase.convert("good_html_page")
      assert "good_html_page" = SnakeCase.convert("GOOD_HTML_PAGE")
    end

    test "works for kebab case" do
      assert "good_html_page" = SnakeCase.convert("good-html-page")
      assert "good_html_page" = SnakeCase.convert("GOOD-HTML-PAGE")
    end

    test "works for camel case" do
      assert "good_html_page" = SnakeCase.convert("goodHtmlPage")
      assert "good_html_page" = SnakeCase.convert("goodHTMLPage")
      assert "good1_html_page" = SnakeCase.convert("good1HTMLPage")
    end

    test "works for pascal case" do
      assert "good_html_page" = SnakeCase.convert("GoodHtmlPage")
      assert "good_html_page" = SnakeCase.convert("GoodHTMLPage")
      assert "good1_html_page" = SnakeCase.convert("Good1HTMLPage")
    end
  end
end
