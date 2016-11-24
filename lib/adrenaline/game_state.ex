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

    answers = get_in(state, [:answers, position])

    unless answers do
      state = put_in(state, [:answers, position], %{})
    end

    state = put_in(state, [:answers, position, player], player_answer)

    {:reply, position, state}
  end
end
