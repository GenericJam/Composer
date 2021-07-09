defmodule ComposerWeb.SurveyController do
  use ComposerWeb, :controller

  alias Composer.Surveys

  @doc """
  List all surveys
  """

  def index(conn, _params) do
    surveys = Surveys.list_surveys()
    render(conn, "index.html", surveys: surveys)
  end

  @doc """
  Show survey
  """
  def show(conn, %{"id" => id}) do
    survey = Surveys.get_survey!(id)
    render(conn, "show.html", survey: survey)
  end
end
