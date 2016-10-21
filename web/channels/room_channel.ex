defmodule Adrenaline.RoomChannel do
  use Phoenix.Channel
  alias Adrenaline.Presence

  def join("room:" <> id, message, socket) do
    send(self, :after_join)

    {:ok, assign(socket, :user_id, message["id"])}
  end

  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{id: socket.assigns.user_id})

    {:noreply, socket}
  end
end
