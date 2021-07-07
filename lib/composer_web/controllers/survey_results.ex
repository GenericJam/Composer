defmodule ComposerWeb.SurveyController do
  use ComposerWeb, :controller

  def create(conn, params) do
    case Composer.Surveys.create_survey(%{form: params}) do
      {:ok, _survey} ->
        conn
        |> put_resp_content_type("text/json")
        |> send_resp(201, "{\"message\":\"Successfully Created Form!\"}")

      _other ->
        conn
        |> put_resp_content_type("text/json")
        |> send_resp(418, "{\"message\":\"Error Creating Form!\"}")
    end
  end
end
