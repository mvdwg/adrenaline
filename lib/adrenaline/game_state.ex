defmodule Adrenaline.GameState do
  use GenServer

  @state %{
    position: -1,
    answers: []
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

    answers = get_in(state, [:answers])

    already_answered = Enum.at(answers, position, [])

    if already_answered == []  do
      already_answered = [%{user_id: player, answer: player_answer}]
      answers = List.insert_at(answers, position, already_answered)
    else
      already_answered = Enum.filter(already_answered, fn(x) -> x.user_id != player end)
      answers = List.replace_at(answers, position, already_answered ++ [%{user_id: player, answer: player_answer}])
    end

    state = put_in(state, [:answers], answers)
    IO.inspect(state)

    {:reply, state, state}
  end
end
