defmodule CardTest do
  use ExUnit.Case
  alias MTGSimulator.Card

  test "start_deck/0 returns a list of cards" do
    deck = Card.start_deck()
    assert is_list(deck)
    assert length(deck) == 20
  end

end
