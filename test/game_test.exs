defmodule GameTest do
  use ExUnit.Case
  alias MTGSimulator.Game

  test "Game.determine_winner/2 when player1 wins" do
    player1 = %MTGSimulator.Player{life: 10}
    player2 = %MTGSimulator.Player{life: 0}

    assert Game.determine_winner(player1, player2) == :player1
  end

  test "Game.determine_winner/2 when player2 wins" do
    player1 = %MTGSimulator.Player{life: 0}
    player2 = %MTGSimulator.Player{life: 10}

    assert Game.determine_winner(player1, player2) == :player2
  end

  test "Game.determine_winner/2 when it's a tie" do
    player1 = %MTGSimulator.Player{life: 0}
    player2 = %MTGSimulator.Player{life: 0}

    assert Game.determine_winner(player1, player2) == :tie

  end

  test "draw_card/1 draws a card from the deck and returns the card and remaining deck" do
    deck = [
      %MTGSimulator.AttackCard{name: "Fireball Cat", damage: 10},
      %MTGSimulator.DefenseCard{name: "Block", block: 5}
    ]

    {card, remaining_deck} = Game.draw_card(deck)

    assert card == %MTGSimulator.AttackCard{name: "Fireball Cat", damage: 10}
    assert remaining_deck == [%MTGSimulator.DefenseCard{name: "Block", block: 5}]
  end

  test "deal_hand/1 deals 5 cards from the deck and returns the hand and remaining deck" do
    deck = [
      %MTGSimulator.AttackCard{name: "Fireball Cat", damage: 10},
      %MTGSimulator.DefenseCard{name: "Block", block: 5},
      %MTGSimulator.AttackCard{name: "Flying Lotus", damage: 5, type: :flying},
      %MTGSimulator.DefenseCard{name: "Heal", effect: :heal},
      %MTGSimulator.AttackCard{name: "Udeon, the Wise", damage: 20},
      %MTGSimulator.DefenseCard{name: "Reverse", effect: :reverse}
    ]

    {hand, remaining_deck} = Game.deal_hand(deck)

    assert length(hand) == 5
    assert length(remaining_deck) == 1
  end

  test "discard_card_for_player/2 removes the picked card from the player's hand" do
    player = %MTGSimulator.Player{
      hand: [
        %MTGSimulator.AttackCard{name: "Fireball Cat", damage: 10},
        %MTGSimulator.DefenseCard{name: "Block", block: 5}
      ]
    }

    picked_card = %MTGSimulator.AttackCard{name: "Fireball Cat", damage: 10}
    updated_player = Game.discard_card_for_player(player, picked_card)

    assert length(updated_player.hand) == 1
    assert Enum.all?(updated_player.hand, fn card -> card.name != picked_card.name end)
  end
end
