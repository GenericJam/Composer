defmodule ComposerWeb.PageLive do
  use ComposerWeb, :live_view

  alias Phoenix.PubSub

  @impl true
  def mount(_params, _session, socket) do
    csrf_token = Plug.CSRFProtection.get_csrf_token()

    PubSub.subscribe(Composer.PubSub, "survey:" <> csrf_token)
    {:ok, assign(socket, csrf_token: csrf_token, submitted: false, empty: false, error: false)}
  end

  # Handle the PubSub from the Channel
  @impl Phoenix.LiveView
  def handle_info(:submitted, socket) do
    {:noreply, assign(socket, submitted: true, empty: false)}
  end

  @impl Phoenix.LiveView
  def handle_info(:empty, socket) do
    {:noreply, assign(socket, empty: true)}
  end

  @impl Phoenix.LiveView
  def handle_info(:error, socket) do
    {:noreply, assign(socket, error: true)}
  end
end
