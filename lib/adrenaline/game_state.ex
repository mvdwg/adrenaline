defmodule Adrenaline.GameState do
  use GenServer

  @state %{
    position: -1,
    answers: %{}
  }

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, @state, name: GameState)
  end

  def handle_call({:increment}, _from, state) do
    position = state.position + 1
    state = %{state | position: position}

    {:reply, position, state}
  end

  def handle_call({:answer, %{player: player, answer: player_answer}}, _from, state) do
    position = state.position
    players = state.answers[position]

    answers = Enum.into(%{position => [player | players]}, state.answers)
    state = Enum.into(%{answers: answers}, state)

    {:reply, position, state}
  end
end
