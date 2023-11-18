defmodule CozyCase.PascalCaseTest do
  use ExUnit.Case
  alias CozyCase.PascalCase

  describe "convert/1" do
    test "works for snake case" do
      assert "GoodHtmlPage" = PascalCase.convert("good_html_page")
      assert "GoodHtmlPage" = PascalCase.convert("GOOD_HTML_PAGE")
    end

    test "works for kebab case" do
      assert "GoodHtmlPage" = PascalCase.convert("good-html-page")
      assert "GoodHtmlPage" = PascalCase.convert("GOOD-HTML-PAGE")
    end

    test "works for camel case" do
      assert "GoodHtmlPage" = PascalCase.convert("goodHtmlPage")
      assert "GoodHtmlPage" = PascalCase.convert("goodHTMLPage")
      assert "Good1HtmlPage" = PascalCase.convert("good1HTMLPage")
    end

    test "works for pascal case" do
      assert "GoodHtmlPage" = PascalCase.convert("GoodHtmlPage")
      assert "GoodHtmlPage" = PascalCase.convert("GoodHTMLPage")
      assert "Good1HtmlPage" = PascalCase.convert("Good1HTMLPage")
    end
  end
end
