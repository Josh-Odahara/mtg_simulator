defmodule MTGSimulator.BattleServer do
  use GenServer
  alias MTGSimulator.Player
  alias MTGSimulator.Game

  def start_link(name1, name2) do
    player1 = Player.new_player(name1)
    player2 = Player.new_player(name2)
    GenServer.start_link(__MODULE__, {player1, player2})
  end

  def play_turn(pid) do
    GenServer.call(pid, :play_turn)
  end

  def log_turn(pid) do
    GenServer.cast(pid, :log_turn)
  end

  def init({player1, player2}) do
    {:ok, %{player1: player1, player2: player2, turn: 1, log: []}}
  end

  def handle_call(:play_turn, _from, %{player1: player1, player2: player2, turn: turn, log: log} = state) do
    {p1, p2} = Game.turn_loop(player1, player2)
    new_state = %{player1: p1, player2: p2, turn: turn + 1, log: log}

    case Game.determine_winner(p1, p2) do
      :player1 -> {:reply, :player1_wins, new_state}
      :player2 -> {:reply, :player2_wins, new_state}
      :tie -> {:reply, {p1, p2}, new_state}
    end
  end

  def handle_cast(:log_turn, state) do
    new_state = %{state | log: ["Turn #{state.turn}: Player 1's turn" | state.log]}
    {:noreply, new_state}
  end
end
