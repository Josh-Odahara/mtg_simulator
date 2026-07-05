defmodule MTGSimulator.Player do
  alias MTGSimulator.Game

  defstruct [:name, :hand, :deck, :life]

  def new_player(name, life) do
    {hand, deck} = Game.new_deck() |> Game.shuffle_deck() |> Game.deal_hand()

    %MTGSimulator.Player{name: name, hand: hand, deck: deck, life: life}
  end
end
