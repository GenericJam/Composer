defmodule ComposerWeb.SurveyController do
  use ComposerWeb, :controller

  def create(conn, params) do
    IO.inspect("ComposerWeb.SurveyController")
    IO.inspect(conn: conn)
    IO.inspect(params: params)
    conn
  end
end
