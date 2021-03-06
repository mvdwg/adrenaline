defmodule Adrenaline.RoomChannel do
  use Phoenix.Channel
  alias Adrenaline.Presence
  alias Adrenaline.Game

  def join("room:" <> id, message, socket) do
    send(self, :after_join)

    {:ok, assign(socket, :user_id, message["id"])}
  end

  def handle_in("new_images", message, socket) do
    position = GenServer.call(GameState, {:increment})
    question = Enum.at(Game.questions, position)

    broadcast! socket, "next_question", question

    {:noreply, socket }
  end

  def handle_in("submit_answer", message, socket) do
    answer = message["answer"]

    position = GenServer.call(GameState, {:answer, %{player: socket.assigns.user_id, answer: answer}})

    broadcast! socket, "question_answered", %{position: position, player: socket.assigns.user_id, answer: answer}

    {:noreply, socket }
  end

  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)

    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{id: socket.assigns.user_id})

    {:noreply, socket}
  end
end
