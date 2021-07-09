defmodule ComposerWeb.SurveyView do
  use ComposerWeb, :view

  alias Composer.Surveys.Survey

  def display(%Survey{form: form}) do
    form |> inspect()
  end

  def render("survey.json", %{survey: survey}) do
    %{id: survey.id, form: survey.form}
  end
end
