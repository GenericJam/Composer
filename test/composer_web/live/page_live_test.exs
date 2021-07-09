defmodule ComposerWeb.PageLiveTest do
  use ComposerWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to Composer"
    assert render(page_live) =~ "Welcome to Composer"
  end
end
