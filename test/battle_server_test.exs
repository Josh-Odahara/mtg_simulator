defmodule BattleServerTest do
use ExUnit.Case
alias MTGSimulator.BattleServer

@tag :skip
test "play_turn returns updated players" do
  {:ok, pid} = BattleServer.start_link("Player 1", "Player 2")
  result = BattleServer.play_turn(pid)
  assert {%MTGSimulator.Player{}, %MTGSimulator.Player{}} = result
end

test "log_turn updates the log" do
  {:ok, pid} = BattleServer.start_link("Player 1", "Player 2")
  BattleServer.log_turn(pid)
  state = :sys.get_state(pid)
  assert ["Turn 1: Player 1's turn" | _] = state.log
end

end
