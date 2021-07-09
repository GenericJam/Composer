defmodule ComposerWeb.SurveyChannel do
  use Phoenix.Channel

  alias Composer.Surveys
  alias Phoenix.PubSub

  def join("survey:new", _message, socket) do
    {:ok, socket}
  end

  @doc """
  Receives survey details from client
  """
  def handle_in("new_survey", %{"body" => %{"csrf" => csrf, "survey" => surveyJSON}}, socket) do
    with json <- surveyJSON |> Jason.decode!(),
         {:ok, _survey} <- Surveys.create_survey(%{form: json}) do
      # Send to the client for debugging
      push(socket, "survey_created", %{body: "success"})
      # Notify the LiveView so it will take down the form and display success message
      PubSub.broadcast(Composer.PubSub, "survey:" <> csrf, :submitted)
    else
      _other ->
        # In the future put error logger here
        push(socket, "survey_created", %{body: "error"})
        PubSub.broadcast(Composer.PubSub, "survey:" <> csrf, :error)
    end

    {:noreply, socket}
  end
end
