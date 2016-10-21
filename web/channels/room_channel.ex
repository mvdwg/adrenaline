defmodule Adrenaline.RoomChannel do
  use Phoenix.Channel

  def join("room:" <> id, _message, socket) do
    {:ok, socket}
  end
end
