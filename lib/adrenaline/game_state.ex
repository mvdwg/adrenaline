defmodule Adrenaline.GameState do
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, %{position: -1}, name: GameState)
  end

  def handle_call({:increment}, _from, state) do
    position = state.position + 1
    state = %{state | position: position}

    {:reply, position, state}
  end
end
