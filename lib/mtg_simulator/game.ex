defmodule MTGSimulator.Game do
@moduledoc """
Game keeps all the logic behind turns and phases
"""
alias Card

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


end
