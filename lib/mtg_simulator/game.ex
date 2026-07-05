defmodule MTGSimulator.Game do
  @moduledoc """
  Game keeps all the logic behind turns and phases
  """
  alias MTGSimulator.Card

  def new_deck() do
    Card.start_deck()
  end

  def shuffle_deck(deck) do
    Enum.shuffle(deck)
  end

  def deal_hand(deck) do
    {hand, remaining_deck} = Enum.split(deck, 5)
    {hand, remaining_deck}
  end

  def determine_winner(player1, player2) do
    player1_score = player1.life
    player2_score = player2.life

    cond do
      player1_score <= 0 -> :player2
      player2_score <= 0 -> :player1
      true -> :tie
    end
  end

end
