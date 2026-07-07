defmodule MTGSimulator.Player do
  alias MTGSimulator.Game

  defstruct [:name, :hand, :deck, life: 100]

  def new_player(name) do
    {hand, deck} = Game.new_deck() |> Game.shuffle_deck() |> Game.deal_hand()

    %MTGSimulator.Player{name: name, hand: hand, deck: deck, life: 100}
  end
end
