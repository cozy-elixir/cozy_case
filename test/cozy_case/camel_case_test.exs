defmodule CozyCase.CamelCaseTest do
  use ExUnit.Case
  alias CozyCase.CamelCase

  describe "convert/1" do
    test "works for snake case" do
      assert "goodHtmlPage" = CamelCase.convert("good_html_page")
      assert "goodHtmlPage" = CamelCase.convert("GOOD_HTML_PAGE")
    end

    test "works for kebab case" do
      assert "goodHtmlPage" = CamelCase.convert("good-html-page")
      assert "goodHtmlPage" = CamelCase.convert("GOOD-HTML-PAGE")
    end

    test "works for camel case" do
      assert "goodHtmlPage" = CamelCase.convert("goodHtmlPage")
      assert "goodHtmlPage" = CamelCase.convert("goodHTMLPage")
      assert "good1HtmlPage" = CamelCase.convert("good1HTMLPage")
    end

    test "works for pascal case" do
      assert "goodHtmlPage" = CamelCase.convert("GoodHtmlPage")
      assert "goodHtmlPage" = CamelCase.convert("GoodHTMLPage")
      assert "good1HtmlPage" = CamelCase.convert("Good1HTMLPage")
    end
  end
end
