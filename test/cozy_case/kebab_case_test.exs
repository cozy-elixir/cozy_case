defmodule CozyCase.KebabCaseTest do
  use ExUnit.Case
  alias CozyCase.KebabCase

  describe "convert/1" do
    test "works for snake case" do
      assert "good-html-page" = KebabCase.convert("good_html_page")
      assert "good-html-page" = KebabCase.convert("GOOD_HTML_PAGE")
    end

    test "works for kebab case" do
      assert "good-html-page" = KebabCase.convert("good-html-page")
      assert "good-html-page" = KebabCase.convert("GOOD-HTML-PAGE")
    end

    test "works for camel case" do
      assert "good-html-page" = KebabCase.convert("goodHtmlPage")
      assert "good-html-page" = KebabCase.convert("goodHTMLPage")
      assert "good1-html-page" = KebabCase.convert("good1HTMLPage")
    end

    test "works for pascal case" do
      assert "good-html-page" = KebabCase.convert("GoodHtmlPage")
      assert "good-html-page" = KebabCase.convert("GoodHTMLPage")
      assert "good1-html-page" = KebabCase.convert("Good1HTMLPage")
    end
  end
end
